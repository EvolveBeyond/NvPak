local lspkind = require('lspkind')
local M = {}
function M.get_formatting()
  return {
    fields = { cmp.ItemField.Abbr, cmp.ItemField.Kind, cmp.ItemField.Menu },
    format = lspkind.cmp_format({
      mode = 'symbol_text', maxwidth = 40,
      before = function(entry, item)
        local icons = { nvim_lsp='[LSP]', mini_snippets='[SNP]', buffer='[BUF]', path='[FIL]' }
        item.kind = lspkind.presets.default[item.kind] or item.kind
        item.menu = icons[entry.source.name] or ''
        return item
      end,
    }),
  }
end
return M
