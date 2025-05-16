local M = {}
function M.setup_cmdline(cmp)
  cmp.setup.cmdline('/', { mapping = cmp.mapping.preset.cmdline(), sources = {{name='nvim_lsp_document_symbol'},{name='buffer'}} })
  cmp.setup.cmdline(':', { mapping = cmp.mapping.preset.cmdline(), sources = {{name='path'},{name='cmdline'}} })
end
return M
