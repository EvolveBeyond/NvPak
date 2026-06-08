-- Plugin entry point
-- This file will be sourced by Neovim at startup if the plugin is installed

-- Example: Expose a setup command
vim.api.nvim_create_user_command('RocksTUISetup', function(opts)
    require('rocks-tui').setup(opts.fargs)
end, { nargs = '*' })

-- Command to open the plugin manager TUI
vim.api.nvim_create_user_command('RocksTUI', function()
    require('rocks-tui.ui').open_plugin_manager()
end, { desc = "Open RocksTUI plugin manager" })

-- Command to open the installation progress window
vim.api.nvim_create_user_command('RocksTUIProgress', function()
    require('rocks-tui.ui').open_installation_progress_window()
end, { desc = "Show RocksTUI installation progress" })

-- Command to open the plugin search TUI
vim.api.nvim_create_user_command('RocksTUISearch', function()
    require('rocks-tui.ui').open_search_window()
end, { desc = "Search for plugins with RocksTUI" })


-- Example: A placeholder command for the TUI
-- vim.api.nvim_create_user_command('RocksTUIOld', function()
--     vim.notify("RocksTUI coming soon!", vim.log.levels.INFO)
-- end, {})

-- You might want to call a setup function from here if you have default configurations
-- require('rocks-tui').setup({})
