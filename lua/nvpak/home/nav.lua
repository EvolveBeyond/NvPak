-- NvPak navigation registry.
-- Foundation for Home / Plugins / LSP / Documentation / Projects / AI screens.
-- Each page is a module exposing { title, render(buf, ctx) } or nil (stub).
-- The Home UI renders whatever page is registered; unimplemented pages
-- render a "coming soon" placeholder. Adding a page = adding a module here.

local M = {}

---@class nvpak.nav.Page
---@field id string
---@field title string
---@field key string autokey in the Home menu
---@field render fun(buf: integer, ctx: table)|nil renders content into buffer
---@field desc string|nil

---@type table<string, nvpak.nav.Page>
M._pages = {}

---Register (or replace) a page.
---@param page nvpak.nav.Page
function M.register(page)
  M._pages[page.id] = page
end

---Get a page by id.
---@param id string
---@return nvpak.nav.Page|nil
function M.get(id)
  return M._pages[id]
end

---All pages in registration order (for the Home menu).
---@return nvpak.nav.Page[]
function M.list()
  local pages = {}
  for _, page in pairs(M._pages) do
    pages[#pages + 1] = page
  end
  table.sort(pages, function(a, b) return a.order < b.order end)
  return pages
end

-- ---------------------------------------------------------------------------
-- Core pages
-- ---------------------------------------------------------------------------

M.register({
  id = "home",
  key = "h",
  order = 1,
  title = "NvPak Home",
  render = nil, -- rendered specially by the home UI
})

M.register({
  id = "plugins",
  key = "p",
  order = 2,
  title = "Plugins",
  desc = "Open the rocks plugin manager",
  render = function()
    vim.cmd("RocksTUI")
  end,
})

-- Stubs for future screens (not implemented yet, by design).
for _, stub in ipairs({
  { id = "lsp", key = "l", order = 3, title = "LSP" },
  { id = "docs", key = "d", order = 4, title = "Documentation" },
  { id = "projects", key = "j", order = 5, title = "Projects" },
  { id = "ai", key = "a", order = 6, title = "AI" },
}) do
  stub.render = function(buf, ctx)
    ctx:line({ { stub.title, "Title" } })
    ctx:line()
    ctx:line({ { "Coming soon in a future NvPak release.", "Comment" } })
  end
  M.register(stub)
end

return M