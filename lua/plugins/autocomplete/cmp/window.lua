local M = {}
function M.get_window()
  return {
    completion    = require('cmp').config.window.bordered(),
    documentation = require('cmp').config.window.bordered(),
  }
end
return M
