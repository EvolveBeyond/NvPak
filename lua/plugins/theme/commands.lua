local M = {}
local manager = require("plugins.ui.theme.manager")

function M.setup()
  vim.api.nvim_create_user_command("SetTheme", function(opts)
    manager.set_theme(opts.args)
  end, {
    nargs = 1,
    complete = function()
      return manager.list_installed_themes()
    end,
    desc = "Set current theme",
  })

  vim.api.nvim_create_user_command("CurrentTheme", function()
    local theme = manager.get_current_theme() or "(none)"
    vim.notify("Current theme: " .. theme)
  end, { desc = "Show current theme" })

  vim.api.nvim_create_user_command("EditTheme", function()
    local theme = manager.get_current_theme()
    if theme then
      vim.cmd("edit " .. require("plugins.ui.theme.config").user_theme_config(theme))
    else
      vim.notify("No theme is set yet.", vim.log.levels.WARN)
    end
  end, { desc = "Edit current theme config" })
end

return M
