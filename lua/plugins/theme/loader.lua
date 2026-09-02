local config = require("plugins.theme.config")
local registry = require("plugins.theme.registry")
local M = {}

-- Load the theme module
function M.load(theme)
  local ok, err = pcall(require, config.plugin_theme_module(theme))
  if not ok then
    vim.notify("Failed to load theme '" .. theme .. "': " .. err, vim.log.levels.ERROR)
  end
end

-- Check if the theme's Lua module exists (non-side-effecting: uses package.searchpath).
-- Does NOT require the theme's rock package to be installed — only checks the
-- bundled lua file under themes/ exists.
function M.is_theme_available(theme)
  local mod = config.plugin_theme_module(theme)
  -- First check if theme file exists in the bundled themes directory
  local theme_file = config.plugin_themes_dir .. "/" .. theme .. ".lua"
  if vim.uv.fs_stat(theme_file) then
    return true
  end
  -- Fallback: check if module is already loadable via package.path (e.g. from luarocks)
  local path = package.searchpath(mod, package.path)
  return path ~= nil
end

-- Check if the theme's underlying rock package (e.g. catppuccin) is installed.
-- Uses the Lua package loader to probe the module without loading it.
function M.is_theme_installed(theme)
  local modname = registry.get_module(theme)
  if modname == nil then
    -- Not in registry; assume the bundled file is the whole story
    return M.is_theme_available(theme)
  end
  -- Probe the module path without requiring it
  local path = package.searchpath(modname, package.path)
  return path ~= nil
end

-- List all bundled theme *.lua files under the plugin themes directory
-- (without extension). These are the themes NvPak ships with.
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
  table.sort(list)
  return list
end

-- List themes that are registered AND installed (ready to apply).
function M.list_installed_themes()
  local result = {}
  for _, theme in ipairs(M.list_available_themes()) do
    if M.is_theme_installed(theme) then
      table.insert(result, theme)
    end
  end
  return result
end

return M
