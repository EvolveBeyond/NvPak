local config = require("plugins.theme.config")
local loader = require("plugins.theme.loader")
local user   = require("plugins.theme.user")

local M = {}

-- Set and apply a new theme
function M.set_theme(name)
  if not loader.is_theme_available(name) then
    vim.notify("Theme '" .. name .. "' not found. Please install it.", vim.log.levels.ERROR)
    return
  end
  loader.load(name)
  user.save_theme(name)
end

-- Get saved theme name
function M.get_current_theme()
  return user.get_saved_theme()
end

-- Load saved theme on startup
function M.load_current_theme()
  local name = user.get_saved_theme()
  if name then loader.load(name) end
end

-- List all bundled themes
function M.list_installed_themes()
  return loader.list_available_themes()
end

return M

