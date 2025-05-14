local config = require("plugins.ui.theme.config")
local loader = require("plugins.ui.theme.loader")
local user = require("plugins.ui.theme.user")

local M = {}

function M.set_theme(name)
  if not loader.is_theme_available(name) then
    vim.notify("Theme '" .. name .. "' not found. Please install it.", vim.log.levels.ERROR)
    return
  end
  loader.load(name)
  user.save_theme(name)
end

function M.get_current_theme()
  return user.get_saved_theme()
end

function M.load_current_theme()
  local name = user.get_saved_theme()
  if name then
    loader.load(name)
  end
end

function M.list_installed_themes()
  return loader.list_available_themes()
end

return M
