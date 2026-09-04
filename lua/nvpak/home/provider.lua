-- NvPak Home data providers.
-- Thin abstraction over rocks.nvim / Neovim / NvPak state.
-- Home UI consumes only this module; it never touches rocks.nvim directly.
--
-- rocks.nvim state functions are async (nio). They must only be called
-- from inside nio.run (see M.refresh). UI renderers read cached values.
-- Network checks must never run at startup — only on user-open or explicit
-- refresh action, and always deferred after first render.

local M = {}

local activity_log_path =
  vim.fs.joinpath(vim.fn.stdpath("data"), "nvpak", "activity.log")

-- ---------------------------------------------------------------------------
-- Activity log (NvPak-owned, persistent)
-- ---------------------------------------------------------------------------

function M.log_activity(kind, message)
  vim.fn.mkdir(vim.fs.dirname(activity_log_path), "p")
  local f = io.open(activity_log_path, "a")
  if not f then return end
  f:write(("%d\t%s\t%s\n"):format(os.time(), kind, message))
  f:close()
end

local function read_activity()
  local f = io.open(activity_log_path, "r")
  if not f then return {} end
  local entries = {}
  for line in f:lines() do
    local epoch, kind, msg = line:match("^(%d+)\t([^\t]*)\t(.*)$")
    if epoch then
      entries[#entries + 1] = { epoch = tonumber(epoch), kind = kind, message = msg }
    end
  end
  f:close()
  table.sort(entries, function(a, b) return (a.epoch or 0) > (b.epoch or 0) end)
  return entries
end

function M.setup_activity_listener()
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("NvPakHomeActivity", { clear = false }),
    pattern = "RocksInstallPost",
    callback = function(args)
      local data = args.data or {}
      local spec = data.spec or {}
      local installed = data.installed or {}
      local name = spec.name or installed.name or "unknown"
      local version = installed.version or spec.version or ""
      M.log_activity("plugin", ("installed %s %s"):format(name, version))
      -- Route into op-state tracking
      if M._op.kind == "update" then
        M._op.update_events = M._op.update_events + 1
      elseif M._op.kind == "install" and name == M._op.target_name then
        M._op.state = "success"
        M._op.label = ("✓ Installed %s %s"):format(name, version)
        M._op.detail = nil
      end
    end,
  })
end

-- ---------------------------------------------------------------------------
-- Cached state (populated by M.refresh; read freely by UI)
-- ---------------------------------------------------------------------------

function M.nvpak_version()
  if M._nvpak_version then return M._nvpak_version end
  local version = "dev"
  local changelog = vim.fs.joinpath(vim.fn.stdpath("config"), "CHANGELOG.md")
  local f = io.open(changelog, "r")
  if f then
    for line in f:lines() do
      local v = line:match("^##%s+%[(.-)%]")
      if v then version = v; break end
      if line:match("^%*%s+%[2026%-Zen%]") then version = "2026.0"; break end
    end
    f:close()
  end
  M._nvpak_version = version
  return version
end

function M.installed_count() return M._installed end
function M.outdated_count() return M._outdated end
function M.outdated_list() return M._outdated_list end
function M.outdated_error() return M._outdated_error end

function M.invalidate()
  M._installed = nil
  M._outdated = nil
  M._outdated_list = nil
  M._outdated_error = nil
  M._system = nil
end

function M.system()
  if M._system then return M._system end
  local sys = {}
  local v = vim.version()
  sys.nvim = ("%d.%d.%d"):format(v.major, v.minor, v.patch)
  sys.rocks = pcall(require, "rocks") and "ok" or "missing"
  sys.config = pcall(function() return require("rocks.api").get_rocks_toml() end) and "ok" or "invalid rocks.toml"
  local clients = vim.lsp.get_clients()
  sys.lsp = #clients > 0 and ("%d running"):format(#clients) or "none active"
  M._system = sys
  return sys
end

function M.activity(limit)
  local entries = read_activity()
  if not limit then return entries end
  local out = {}
  for i = 1, math.min(limit, #entries) do out[#out + 1] = entries[i] end
  return out
end

function M.last_activity()
  local e = read_activity()[1]
  if not e or not e.epoch then return "never" end
  local diff = os.time() - e.epoch
  if diff < 60 then return "just now"
  elseif diff < 3600 then return ("%dm ago"):format(math.floor(diff / 60))
  elseif diff < 86400 then return ("%dh ago"):format(math.floor(diff / 3600))
  else return ("%dd ago"):format(math.floor(diff / 86400)) end
end

-- ---------------------------------------------------------------------------
-- Async data refresh (local luarocks query, NO network)
-- Deferred 2s to let rocks.nvim state populate on cold start.
-- ---------------------------------------------------------------------------

function M.refresh(on_done)
  vim.defer_fn(function()
    local ok_nio, nio = pcall(require, "nio")
    if not ok_nio then
      M._refresh_error = "rocks.nvim unavailable"
      if on_done then on_done() end
      return
    end
    nio.run(function()
      local ok, installed = pcall(require("rocks.state").installed_rocks)
      if ok and type(installed) == "table" then
        local n = 0; for _ in pairs(installed) do n = n + 1 end
        M._installed = n
        M._refresh_error = nil
      else
        M._refresh_error = "rocks state unavailable"
      end
      M._system = nil; M.system()
      if on_done then on_done() end
    end)
  end, 2000)
end

function M.refresh_error() return M._refresh_error end

-- ---------------------------------------------------------------------------
-- Outdated check (NETWORK — only on user action, never at startup)
-- ---------------------------------------------------------------------------

local _checking = false

function M.is_checking() return _checking end

function M.check_outdated(on_result)
  _checking = true
  local ok_nio, nio = pcall(require, "nio")
  if not ok_nio then
    _checking = false
    M._outdated = nil
    M._outdated_list = nil
    M._outdated_error = "rocks.nvim unavailable"
    if on_result then on_result(nil, nil) end
    return
  end
  nio.run(function()
    local ok, outdated = pcall(require("rocks.state").outdated_rocks)
    _checking = false
    if ok and type(outdated) == "table" then
      local list = {}
      for _, rock in pairs(outdated) do
        list[#list + 1] = ("%s %s -> %s"):format(rock.name, rock.version, rock.target_version)
      end
      table.sort(list)
      M._outdated = #list
      M._outdated_list = list
      M._outdated_error = nil
      if on_result then on_result(#list, list) end
    else
      M._outdated = nil
      M._outdated_list = nil
      M._outdated_error = "update check failed (offline?)"
      if on_result then on_result(nil, nil) end
    end
  end)
end

-- ---------------------------------------------------------------------------
-- Operation state machine (Issue 2: Home-owned operation states)
-- ---------------------------------------------------------------------------

---@alias OpKind "none"|"update"|"install"|"refresh"
---@alias OpState "idle"|"running"|"success"|"failure"

---@class OpState
---@field kind OpKind
---@field state OpState
---@field label string  e.g. "Updating plugins…"
---@field detail string|nil  e.g. "✓ Updated 4 plugins"
---@field count number|nil

M._op = { kind = "none", state = "idle", label = nil, detail = nil, count = nil, target_name = nil, update_events = 0, update_outdated_before = 0 }

function M.op_state() return M._op end

function M._begin_op(kind, label)
  M._op = { kind = kind, state = "running", label = label, detail = nil, count = nil, target_name = nil, update_events = 0, update_outdated_before = 0 }
end

-- ---------------------------------------------------------------------------
-- Update all (async via rocks.nvim operations)
-- ---------------------------------------------------------------------------

function M.update_all(on_complete)
  local snap = M._outdated or 0
  M._begin_op("update", "Updating plugins…")
  M._op.update_outdated_before = snap
  M._op.update_events = 0

  M.log_activity("update", "update started")

  local ok_ops, rocks_ops = pcall(require, "rocks.operations")
  if not ok_ops then
    M._op.state = "failure"
    M._op.label = "✗ Update failed — rocks.nvim unavailable"
    M._op.detail = nil
    M.log_activity("update", M._op.label)
    if on_complete then on_complete() end
    return
  end
  rocks_ops.update(vim.schedule_wrap(function()
    -- on_complete fires unconditionally (success or partial failure)
    local function finalize()
      local events = M._op.update_events or 0
      local before = M._op.update_outdated_before or 0
      if before == 0 and events == 0 then
        M._op.state = "success"
        M._op.label = "✓ All plugins up to date"
        M._op.detail = nil
      elseif events > 0 and (before == 0 or events >= before) then
        M._op.state = "success"
        M._op.label = ("✓ Updated %d plugin%s"):format(events, events == 1 and "" or "s")
        M._op.detail = nil
      elseif events > 0 and before > 0 and events < before then
        M._op.state = "success"
        M._op.label = ("✓ Updated %d plugin%s, %d still outdated"):format(events, events == 1 and "" or "s", before - events)
        M._op.detail = nil
      else
        M._op.state = "failure"
        M._op.label = "✗ Update failed — no plugins were updated"
        M._op.detail = "check :Rocks log for details"
      end
      M.invalidate()
      M.log_activity("update", M._op.label)
      if on_complete then on_complete() end
    end

    -- Requery outdated asynchronously to determine final state
    require("nio").run(function()
      local ok, outdated = pcall(require("rocks.state").outdated_rocks)
      if ok and type(outdated) == "table" then
        local count = 0; for _ in pairs(outdated) do count = count + 1 end
        M._outdated = count
      end
      finalize()
    end)
  end))
end

-- ---------------------------------------------------------------------------
-- Install a plugin (async via rocks.nvim operations)
-- ---------------------------------------------------------------------------

local _install_timeout = nil

function M.install(name, on_complete)
  if not name or name == "" then return end
  M._begin_op("install", ("Installing %s…"):format(name))
  M._op.target_name = name
  M.log_activity("plugin", ("install requested: %s"):format(name))

  local ok_ops, rocks_ops = pcall(require, "rocks.operations")
  if not ok_ops then
    M._op.state = "failure"
    M._op.label = ("✗ Failed to install %s — rocks.nvim unavailable"):format(name)
    M._op.detail = nil
    M.log_activity("plugin", ("install failed: rocks.nvim unavailable: %s"):format(name))
    if on_complete then on_complete() end
    return
  end
  rocks_ops.add({ name }, {
    callback = function(rock)
      if M._op.kind == "install" and M._op.target_name == name then
        M._op.state = "success"
        M._op.label = ("✓ Installed %s %s"):format(rock.name, rock.version)
        M._op.detail = nil
        M.log_activity("plugin", ("installed %s %s"):format(rock.name, rock.version))
      end
      if on_complete then on_complete() end
    end,
  })

  -- Safety timeout: if no success signal after 120s, report failure
  if _install_timeout then pcall(vim.fn.timer_stop, _install_timeout) end
  _install_timeout = vim.fn.timer_start(120000, function()
    if M._op.kind == "install" and M._op.state == "running" then
      M._op.state = "failure"
      M._op.label = ("✗ Failed to install %s (timeout)"):format(name)
      M._op.detail = "check :Rocks log for details"
      M.log_activity("plugin", ("install timed out: %s"):format(name))
    end
    _install_timeout = nil
  end)
end

-- ---------------------------------------------------------------------------
-- Refresh action (data-only, no network, no package ops)
-- ---------------------------------------------------------------------------

function M.refresh_action(on_done)
  M._begin_op("refresh", "Refreshing…")
  M.invalidate()
  M.refresh(function()
    M._op.state = "success"
    M._op.label = "✓ Refreshed"
    M._op.detail = nil
    if on_done then on_done() end
  end)
end

return M
