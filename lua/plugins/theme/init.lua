-- File: lua/plugins/theme/init.lua

local M = {}

local manager  = require("plugins.theme.manager")
local commands = require("plugins.theme.commands")

-- Load user preferred theme on startup
manager.load_current_theme()

-- Register user commands
commands.setup()

return M
