local cmp_compare = require('cmp.config.compare')
local M = {}
function M.get_sorting()
  return {
    priority_weight = 1.0,
    comparators = {
      cmp_compare.offset, cmp_compare.exact, cmp_compare.score,
      cmp_compare.recently_used, cmp_compare.kind,
      cmp_compare.sort_text, cmp_compare.length, cmp_compare.order,
    },
    debug = { priority = true },
  }
end
return M
