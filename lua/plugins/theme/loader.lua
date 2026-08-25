local config = require("plugins.theme.config")
local M = {}

-- Load the theme module
function M.load(theme)
  local ok, err = pcall(require, config.plugin_theme_module(theme))
  if not ok then
    vim.notify("Failed to load theme '" .. theme .. "': " .. err, vim.log.levels.ERROR)
  end
end

-- Check if theme module exists (non-side-effecting: uses package.searchpath)
function M.is_theme_available(theme)
  local mod = config.plugin_theme_module(theme)
  local path = package.searchpath(mod, package.path)
  return path ~= nil
end

-- List all *.lua files under plugin themes directory (without extension)
function M.list_available_themes()
  local list = {}
  local scan = vim.uv.fs_scandir(config.plugin_themes_dir)
  if scan then
    while true do
      local name, t = vim.uv.fs_scandir_next(scan)
      if not name then break end
      if t == "file" and name:match("(.*)%.lua$") then
        table.insert(list, name:match("(.*)%.lua$"))
      end
    end
  end
  return list
end

return M

