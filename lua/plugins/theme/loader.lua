local config = require("plugins.ui.theme.config")
local M = {}

function M.load(theme)
  local ok, _ = pcall(require, config.plugin_theme_module(theme))
  if not ok then
    vim.notify("Failed to load theme '" .. theme .. "'", vim.log.levels.ERROR)
  end
end

function M.is_theme_available(theme)
  local ok = pcall(require, config.plugin_theme_module(theme))
  return ok
end

function M.list_available_themes()
  local path = vim.fn.stdpath("data") .. "/rocks/lib/luarocks/rocks-5.1/plugins.ui.colors"
  local list = {}
  local scan = vim.loop.fs_scandir(path)
  if scan then
    while true do
      local name, t = vim.loop.fs_scandir_next(scan)
      if not name then break end
      if t == "directory" then
        table.insert(list, name)
      end
    end
  end
  return list
end

return M
