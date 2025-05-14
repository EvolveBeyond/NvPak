local M = {}

local manager = require("plugins.ui.theme.manager")
local commands = require("plugins.ui.theme.commands")

-- Load user preferred theme on startup
manager.load_current_theme()

-- Register user commands
commands.setup()

return M
