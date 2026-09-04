-- NvPak Home — the primary NvPak dashboard / control center.
-- Not a splash screen, not a generic dashboard: it is the distro's
-- command center and the default landing page on bare `nvim` startup.
-- Native Neovim buffer UI. No new dependencies, no UI framework.
-- Data comes exclusively from nvpak.home.provider and nvpak.home.nav.

local M = {}

local provider = require("nvpak.home.provider")
local nav = require("nvpak.home.nav")

local NS = vim.api.nvim_create_namespace("nvpak-home")

local HEADER = [[
███╗   ██╗██╗   ██╗██████╗  █████╗ ██╗  ██╗
████╗  ██║██║   ██║██╔══██╗██╔══██╗██║  ██║
██╔██╗ ██║██║   ██║██████╔╝███████║███████║
██║╚██╗██║╚██╗ ██╔╝██╔═══╝ ██╔══██║██╔══██║
██║ ╚████║ ╚████╔╝ ██║     ██║  ██║██║  ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝]]

local STATE = { buf = nil, win = nil, error = nil, showing_help = false }

-- ---------------------------------------------------------------------------
-- Rendering helpers
-- ---------------------------------------------------------------------------

local Renderer = {}
Renderer.__index = Renderer

function Renderer.new(buf, max_width)
  return setmetatable({ buf = buf, rows = {}, marks = {}, max_width = max_width or 80 }, Renderer)
end

function Renderer:line(segments)
  segments = segments or {}
  local row = #self.rows + 1
  local texts = {}
  local col = 0
  for _, seg in ipairs(segments) do
    local text, hl = seg[1], seg[2]
    texts[#texts + 1] = text
    if hl and (self.max_width <= 0 or col + vim.fn.strdisplaywidth(text) <= self.max_width) then
      self.marks[#self.marks + 1] = { row = row, col = col, hl = hl }
    end
    col = col + vim.fn.strdisplaywidth(text)
  end
  local line_text = table.concat(texts)
  if self.max_width > 0 and vim.fn.strdisplaywidth(line_text) > self.max_width then
    self.rows[#self.rows + 1] = vim.fn.strcharpart(line_text, 0, self.max_width - 1) .. "…"
  else
    self.rows[#self.rows + 1] = line_text
  end
end

function Renderer:blank() self:line() end
function Renderer:heading(text) self:line({ { text, "NvPakHomeSection" } }) end

function Renderer:kv(label, value, value_hl, width)
  width = width or 16
  local padding = width - vim.fn.strdisplaywidth(label)
  if padding < 1 then padding = 1 end
  self:line({
    { "  " .. label .. string.rep(" ", padding), "NvPakHomeKey" },
    { tostring(value), value_hl or "Normal" },
  })
end

function Renderer:apply()
  vim.bo[self.buf].modifiable = true
  vim.api.nvim_buf_set_lines(self.buf, 0, -1, false, self.rows)
  vim.bo[self.buf].modifiable = false
  vim.api.nvim_buf_clear_namespace(self.buf, NS, 0, -1)
  for _, m in ipairs(self.marks) do
    local line_len = #self.rows[m.row] or 0
    local end_col = math.min(m.col + 1, line_len)
    if m.col < line_len then
      pcall(vim.api.nvim_buf_set_extmark, self.buf, NS, m.row - 1, m.col, {
        end_row = m.row - 1, end_col = end_col, hl_group = m.hl,
      })
    end
  end
end

local function seg(text, hl) return { { text, hl } } end

-- ---------------------------------------------------------------------------
-- Section renderers (Home page)
-- ---------------------------------------------------------------------------

local function render_overview(r)
  r:heading("OVERVIEW")
  local count = provider.installed_count()
  local outdated = provider.outdated_count()
  r:kv("Version", provider.nvpak_version())
  r:kv("Plugins", count and tostring(count) or "loading…")
  if provider.is_checking() then
    r:kv("Updates", "checking…", "NvPakHomeInfo")
  elseif provider.outdated_error() then
    r:kv("Updates", provider.outdated_error(), "NvPakHomeWarn")
  elseif outdated == nil then
    r:kv("Updates", "not checked", "NvPakHomeKey")
  elseif outdated == 0 then
    r:kv("Updates", "all up to date", "NvPakHomeOk")
  else
    r:kv("Updates", ("%d available"):format(outdated), "NvPakHomeWarn")
  end
  r:kv("Last activity", provider.last_activity())
  r:blank()
end

local function render_plugin_center(r)
  r:heading("PLUGIN CENTER")
  local count = provider.installed_count()
  if count == nil then
    r:line({ { "  loading plugin data…", "Comment" } })
  else
    r:kv("Installed", tostring(count))
    local outdated = provider.outdated_count()
    if provider.is_checking() then
      r:kv("Updates", "checking…", "NvPakHomeInfo")
    elseif provider.outdated_error() then
      r:kv("Updates", provider.outdated_error(), "NvPakHomeWarn")
    elseif outdated == nil then
      r:kv("Updates", "not checked", "NvPakHomeKey")
    elseif outdated == 0 then
      r:kv("Updates", "none", "NvPakHomeOk")
    else
      r:kv("Updates", tostring(outdated), "NvPakHomeWarn")
      for _, item in ipairs(provider.outdated_list() or {}) do
        r:line({ { "    " .. item, "NvPakHomeWarn" } })
      end
    end
  end
  -- Operation state display (Issue 2: Home-owned op states)
  local op = provider.op_state()
  if op.kind ~= "none" then
    local hl = op.state == "running" and "NvPakHomeInfo"
      or op.state == "success" and "NvPakHomeOk"
      or op.state == "failure" and "NvPakHomeError"
      or "NvPakHomeKey"
    r:blank()
    r:line({ { "  " .. (op.label or ""), hl } })
    if op.detail then
      r:line({ { "    " .. op.detail, "Comment" } })
    end
  end
  if STATE.error then
    r:blank()
    r:line({ { "  " .. STATE.error, "NvPakHomeError" } })
  end
  r:blank()
end

local function render_system(r)
  r:heading("SYSTEM STATUS")
  local sys = provider.system()
  r:kv("Neovim", sys.nvim)
  r:kv("rocks.nvim", sys.rocks, sys.rocks == "ok" and "NvPakHomeOk" or "NvPakHomeError")
  r:kv("Config", sys.config, sys.config == "ok" and "NvPakHomeOk" or "NvPakHomeError")
  r:kv("LSP", sys.lsp)
  r:blank()
end

local function render_activity(r)
  r:heading("RECENT ACTIVITY")
  local entries = provider.activity(5)
  if #entries == 0 then
    r:line({ { "  no activity yet", "Comment" } })
  else
    for _, e in ipairs(entries) do
      local ts = os.date("%m-%d %H:%M", e.epoch or 0)
      r:line({ { ("  %s "):format(ts), "NvPakHomeKey" }, { e.message, "Normal" } })
    end
  end
  r:blank()
end

local function render_commands(r)
  r:heading("COMMAND CENTER")
  for _, c in ipairs({
    { key = "u", desc = "Update all plugins" },
    { key = "i", desc = "Install plugin" },
    { key = "r", desc = "Refresh" },
    { key = "s", desc = "System check" },
    { key = "o", desc = "Open documentation" },
    { key = "m", desc = "Open plugin manager" },
  }) do
    r:line({ { ("  [%s]"):format(c.key), "NvPakHomeAction" }, { " " .. c.desc, "Normal" } })
  end
  r:blank()
end

local function render_nav(r)
  r:heading("NAVIGATE")
  for _, page in ipairs(nav.list()) do
    if page.id ~= "home" then
      r:line({
        { ("  [%s]"):format(page.key), "NvPakHomeAction" },
        { " " .. page.title, "Normal" },
        page.desc and { "  - " .. page.desc, "Comment" } or nil,
      })
    end
  end
  r:blank()
end

local function render_help(r)
  r:heading("KEYS")
  for _, entry in ipairs({
    { key = "q", desc = "Close Home" },
    { key = "r", desc = "Refresh data" },
    { key = "u", desc = "Update all plugins" },
    { key = "i", desc = "Install plugin" },
    { key = "s", desc = "System check" },
    { key = "o", desc = "Open documentation" },
    { key = "m", desc = "Open plugin manager (RocksTUI)" },
    { key = "p", desc = "Plugins (RocksTUI)" },
    { key = "l", desc = "LSP (coming soon)" },
    { key = "d", desc = "Documentation (coming soon)" },
    { key = "j", desc = "Projects (coming soon)" },
    { key = "a", desc = "AI (coming soon)" },
  }) do
    r:line({ { ("  [%s]"):format(entry.key), "NvPakHomeAction" }, { " " .. entry.desc, "Normal" } })
  end
  r:blank()
  r:line(seg("  [?] back to Home  [q] close", "Comment"))
end

---Render the home page content into the buffer.
local function render_home(buf)
  local width = 0
  local win = STATE.win
  if win and vim.api.nvim_win_is_valid(win) then
    width = vim.api.nvim_win_get_width(win)
  else
    width = vim.o.columns
  end
  local r = Renderer.new(buf, width)

  if STATE.showing_help then
    render_help(r)
  else
    if width >= 50 then
      for _, l in ipairs(vim.split(HEADER, "\n")) do
        r:line(seg(l, "NvPakHomeLogo"))
      end
      r:line(seg(("  NvPak Control Center  v%s"):format(provider.nvpak_version()), "NvPakHomeTitle"))
    else
      r:line(seg("NvPak Home", "NvPakHomeTitle"))
    end
    r:blank()
    render_overview(r)
    render_plugin_center(r)
    render_system(r)
    render_activity(r)
    render_commands(r)
    render_nav(r)
    r:line(seg("  [q] close  [?] toggles help", "Comment"))
  end

  r:apply()
end

-- ---------------------------------------------------------------------------
-- Window / buffer management
-- ---------------------------------------------------------------------------

local function buf_valid()
  return STATE.buf and vim.api.nvim_buf_is_valid(STATE.buf)
end

local function create_buf()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = "hide"
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].swapfile = false
  vim.bo[buf].modifiable = false
  vim.api.nvim_buf_set_name(buf, "nvpak://home")
  return buf
end

local function redraw()
  if buf_valid() then render_home(STATE.buf) end
end

local function close()
  if STATE.win and vim.api.nvim_win_is_valid(STATE.win) then
    vim.api.nvim_win_close(STATE.win, true)
  end
  STATE.win = nil
end

local function set_keymaps(buf)
  local function map(key, fn, desc)
    vim.keymap.set("n", key, fn,
      { buffer = buf, silent = true, nowait = true, desc = "NvPakHome: " .. desc })
  end

  map("q", close, "close home")

  map("?", function()
    STATE.showing_help = not STATE.showing_help
    redraw()
  end, "toggle help")

  map("r", function()
    provider.refresh_action(function() vim.schedule(redraw) end)
    vim.defer_fn(redraw, 100)
  end, "refresh data")

  map("u", function()
    provider.update_all(function() vim.schedule(redraw) end)
    redraw()
  end, "update all plugins")

  map("i", function()
    vim.ui.input({ prompt = "Plugin name to install: " }, function(name)
      if not name or name == "" then return end
      provider.install(name, function() vim.schedule(redraw) end)
      redraw()
    end)
  end, "install plugin")

  map("s", function()
    provider.invalidate()
    local sys = provider.system()
    local msg = ("nvim %s | rocks: %s | config: %s | lsp: %s")
      :format(sys.nvim, sys.rocks, sys.config, sys.lsp)
    STATE.error = "system check — " .. msg
    redraw()
  end, "system check")

  map("o", function()
    close()
    vim.cmd("help nvpak-home")
  end, "open documentation")

  map("m", function()
    if pcall(require, "rocks-tui") then
      vim.cmd("RocksTUI")
    else
      STATE.error = "plugin manager (rocks-tui) not installed"
      redraw()
    end
  end, "open plugin manager")

  for _, page in ipairs(nav.list()) do
    if page.id ~= "home" then
      map(page.key, function()
        if page.id == "plugins" then
          close()
          if pcall(require, "rocks-tui") then vim.cmd("RocksTUI") end
          return
        end
        local r = Renderer.new(STATE.buf)
        r:line(seg("< " .. page.title .. " >", "NvPakHomeTitle"))
        r:blank()
        r:line(seg("This section is reserved for a future NvPak release.", "Comment"))
        r:blank()
        r:line(seg("  [h] back to home  [q] close", "Comment"))
        r:apply()
        vim.keymap.set("n", "h", function()
          STATE.showing_help = false
          redraw()
        end, { buffer = STATE.buf, silent = true, nowait = true, desc = "NvPakHome: back to home" })
      end, "navigate: " .. page.title)
    end
  end
end

-- ---------------------------------------------------------------------------
-- Open / close / setup
-- ---------------------------------------------------------------------------

function M.open()
  if not buf_valid() then
    STATE.buf = create_buf()
    STATE.showing_help = false
    set_keymaps(STATE.buf)
  end

  local lines_total = vim.o.lines
  local cols_total = vim.o.columns
  local width = math.min(math.max(cols_total - 4, 20),
    math.max(60, math.floor(cols_total * 0.7)))
  local height = math.min(math.max(lines_total - 6, 10),
    math.max(24, math.floor(lines_total * 0.8)))

  local win = vim.api.nvim_open_win(STATE.buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((lines_total - height) / 2),
    col = math.floor((cols_total - width) / 2),
    style = "minimal",
    border = "rounded",
    title = " NvPak Home ",
    title_pos = "center",
  })
  STATE.win = win

  -- Issue 1+3: render UI IMMEDIATELY, then defer all network/package queries
  render_home(STATE.buf)

  -- Local data refresh (no network, but still async to avoid blocking render)
  provider.refresh(function() vim.schedule(redraw) end)

  -- Issue 1: network check deferred AFTER first render is visible
  vim.defer_fn(function()
    if not buf_valid() then return end
    provider.check_outdated(function()
      vim.schedule(redraw)
    end)
  end, 1500)
end

function M.is_open()
  return STATE.win ~= nil and vim.api.nvim_win_is_valid(STATE.win)
end

function M.close()
  if M.is_open() then
    vim.api.nvim_win_close(STATE.win, true)
    STATE.win = nil
  end
end

function M.toggle()
  if M.is_open() then M.close() else M.open() end
end

---Should Home auto-open on this invocation? True for bare `nvim`:
---no file arguments, no +/-/dash options (stdin, cmds, flags).
---Headless is NOT excluded: `nvim --headless` (e.g. tests, scripts) still
---lands on Home unless the caller passes landing=false or file args.
function M.should_land(argv)
  argv = argv or vim.v.argv
  if vim.fn.argc(-1) ~= 0 then return false end
  for _, a in ipairs(argv) do
    if a:match("^%+") or a:match("^%-") then return false end
  end
  return true
end

function M.setup(opts)
  opts = opts or {}

  vim.api.nvim_set_hl(0, "NvPakHomeLogo", { link = "Special", default = true })
  vim.api.nvim_set_hl(0, "NvPakHomeTitle", { link = "Title", default = true })
  vim.api.nvim_set_hl(0, "NvPakHomeSection", { link = "Title", default = true })
  vim.api.nvim_set_hl(0, "NvPakHomeKey", { link = "Comment", default = true })
  vim.api.nvim_set_hl(0, "NvPakHomeOk", { link = "DiagnosticOk", default = true })
  vim.api.nvim_set_hl(0, "NvPakHomeWarn", { link = "DiagnosticWarn", default = true })
  vim.api.nvim_set_hl(0, "NvPakHomeError", { link = "DiagnosticError", default = true })
  vim.api.nvim_set_hl(0, "NvPakHomeInfo", { link = "DiagnosticInfo", default = true })
  vim.api.nvim_set_hl(0, "NvPakHomeAction", { link = "Special", default = true })

  provider.setup_activity_listener()

  vim.api.nvim_create_user_command("NvPakHome", function() M.toggle() end,
    { desc = "Toggle the NvPak Home control center" })

  vim.keymap.set("n", "<leader>H", function() M.toggle() end,
    { desc = "NvPak Home" })

  -- Home is the default landing page on bare `nvim`.
  -- Escape hatch: :NvPakHome toggles it away anytime. Opt out: landing=false.
  if opts.landing ~= false and M.should_land() then
    vim.schedule(function() M.open() end)
  end

  -- Issue 3: NO network, NO package operations at startup.
  -- setup() only registers highlights, user command, keymap, and activity listener.
  -- All data fetching is deferred to open() → provider.refresh / check_outdated.
end

return M
