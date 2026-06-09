local M = {}
function M.get_sources()
  return cmp.config.sources({
    { name = 'nvim_lsp',        keyword_length = 1, max_item_count = 11 },
    { name = 'mini_snippets',   keyword_length = 2, max_item_count = 5  },
  }, {
    {
      name = 'buffer', keyword_length = 3, max_item_count = 10,
      option = { get_bufnrs = function()
        local bufs = {}
        for _, w in ipairs(vim.api.nvim_list_wins()) do bufs[vim.api.nvim_win_get_buf(w)] = true end
        return vim.tbl_keys(bufs)
      end }
    },
    { name = 'path',     keyword_length = 3, max_item_count = 5 },
    { name = 'spell',    keyword_length = 3, option = {
        keep_all_entries = false,
        enable_in_context = function() return true end,
    }},
    { name = 'nvim_lsp_signature_help' },
  })
end
return M
