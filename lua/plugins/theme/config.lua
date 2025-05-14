local M = {}

local config_dir = vim.fn.stdpath("config")
local local_config_dir = vim.fn.stdpath("data") .. "/nvpak/themes"

M.user_config_path = function()
  return local_config_dir
end

M.user_theme_file = function()
  return local_config_dir .. "/current_theme"
end

M.user_theme_config = function(theme)
  return local_config_dir .. "/" .. theme .. ".lua"
end

M.plugin_theme_module = function(theme)
  return "plugins.ui.colors." .. theme
end

return M
