-- Main module for rocks-tui
local M = {}

local config_module = require('rocks-tui.config')

--- Setup function for the rocks-tui plugin.
--- Users can call this from their Neovim configuration.
--- @param user_config table|nil User configuration to override defaults.
function M.setup(user_config)
  config_module.setup(user_config)
  vim.notify("rocks-tui setup complete.", vim.log.levels.INFO)
end

--- Returns the current configuration, mainly for internal use or debugging.
function M.get_current_config()
    return config_module.get_config()
end

return M
