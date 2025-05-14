local vim = vim
local fn  = vim.fn

local M = {}

-- Directory under stdpath("data") to store user theme settings
M.user_dir = fn.stdpath("data") .. "/nvpak/themes"

-- Path to plain file storing current theme name
M.user_theme_file = M.user_dir .. "/current_theme"

-- Path to user-editable theme config for a given theme
M.user_theme_config = function(theme)
  return M.user_dir .. "/" .. theme .. ".lua"
end

-- Module path prefix for bundled theme definitions
M.plugin_theme_module = function(theme)
  return "plugins.theme.themes." .. theme
end

-- Directory where bundled themes reside
M.plugin_themes_dir = fn.stdpath("config") .. "/lua/plugins/theme/themes"

return M
