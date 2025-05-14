local config = require("plugins.ui.theme.config")
local M = {}

function M.save_theme(theme)
  vim.fn.mkdir(config.user_config_path(), "p")
  local f = io.open(config.user_theme_file(), "w")
  if f then
    f:write(theme)
    f:close()
  end
end

function M.get_saved_theme()
  local f = io.open(config.user_theme_file(), "r")
  if f then
    local theme = f:read("*l")
    f:close()
    return theme
  end
end

return M

