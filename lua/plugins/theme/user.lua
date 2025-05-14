local config = require("plugins.theme.config")
local io     = io

local M = {}

-- Save current theme name to user file
function M.save_theme(theme)
  vim.fn.mkdir(config.user_dir, "p")
  local f = io.open(config.user_theme_file, "w")
  if f then f:write(theme); f:close() end
end

-- Retrieve saved theme name, or nil
function M.get_saved_theme()
  local f = io.open(config.user_theme_file, "r")
  if f then
    local theme = f:read("*l")
    f:close()
    return theme
  end
end

return M
