local M       = {}
local config  = require("plugins.theme.config")
local manager = require("plugins.theme.manager")
local loader  = require("plugins.theme.loader")

function M.setup()
  vim.api.nvim_create_user_command("SetTheme", function(opts)
    manager.set_theme(opts.args)
  end, {
    nargs = 1,
    complete = function() return manager.list_installed_themes() end,
    desc = "Set current theme",
  })

  vim.api.nvim_create_user_command("CurrentTheme", function()
    local theme = manager.get_current_theme() or "(none)"
    vim.notify("Current theme: " .. theme)
  end, { desc = "Show current theme" })

  vim.api.nvim_create_user_command("EditTheme", function()
    local theme = manager.get_current_theme()
    if theme then
      local path = config.user_theme_config(theme)
      if vim.uv.fs_stat(path) then
        vim.cmd("edit " .. path)
      else
        vim.notify("User config for theme '" .. theme .. "' not found.", vim.log.levels.WARN)
      end
    else
      vim.notify("No theme is set yet.", vim.log.levels.WARN)
    end
  end, { desc = "Edit current theme config" })

  -- ThemeInfo: show install status of the current theme
  vim.api.nvim_create_user_command("ThemeInfo", function()
    local theme = manager.get_current_theme()
    if not theme then
      vim.notify("No theme is set yet.", vim.log.levels.WARN)
      return
    end
    local pkg = manager.get_theme_package(theme)
    local ready = loader.is_theme_installed(theme)
    local status = ready and "installed" or "available (run :Rocks sync)"
    local msg = ("Theme: %s\nPackage: %s\nStatus: %s"):format(
      theme, pkg or "(bundled)", status)
    vim.notify(msg, vim.log.levels.INFO, { title = "NvPak Theme" })
  end, { desc = "Show current theme install status" })
end

return M
