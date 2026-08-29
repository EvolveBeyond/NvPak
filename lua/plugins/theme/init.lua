-- File: lua/plugins/theme/init.lua

local M = {}

local manager  = require("plugins.theme.manager")
local commands = require("plugins.theme.commands")
local registry = require("plugins.theme.registry")

-- Validate registry at startup (lazy, no side effects)
vim.defer_fn(function()
  local known = registry.list_known_themes()
  if #known == 0 then
    vim.notify("NvPak: Theme registry empty!", vim.log.levels.WARN)
  end
end, 0)

-- Load user preferred theme on startup
manager.load_current_theme()

-- Register user commands
commands.setup()

return M