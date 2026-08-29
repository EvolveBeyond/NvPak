-- Theme Resource Registry
-- Maps NvPak theme identifiers to their rocks.nvim package names.
-- This allows the manager to know which package a theme depends on,
-- without requiring the package to be installed or loaded.
local M = {}

-- theme_id -> rock package name (as declared in rocks.toml)
M.theme_packages = {
  catppuccin   = "catppuccin",
  onedarkpro   = "onedarkpro.nvim",
  dracula      = "dracula",
  monokia      = "monokia",
  nord         = "nord",
  ["rose-pine"] = "rose-pine",
}

-- theme_id -> module to require (the colorscheme setup entrypoint)
M.theme_modules = {
  catppuccin   = "catppuccin",
  onedarkpro   = "onedarkpro",
  dracula      = "dracula",
  monokia      = "monokai",
  nord         = "nord",
  ["rose-pine"] = "rose-pine",
}

-- Returns the rocks package name for a theme id, or nil if unknown.
function M.get_package(theme)
  return M.theme_packages[theme]
end

-- Returns the module name that the theme's setup file requires.
function M.get_module(theme)
  return M.theme_modules[theme]
end

-- All known theme ids (registry keys).
function M.list_known_themes()
  local list = {}
  for id, _ in pairs(M.theme_packages) do
    table.insert(list, id)
  end
  table.sort(list)
  return list
end

-- True if the theme id is registered (regardless of install state).
function M.is_registered(theme)
  return M.theme_packages[theme] ~= nil
end

return M
