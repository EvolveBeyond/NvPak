local M = {}
function M.setup_mapping(cmp)
  return cmp.mapping.preset.insert({
    ["<C-n>"]     = cmp.mapping.select_next_item(),
    ["<C-p>"]     = cmp.mapping.select_prev_item(),
    ["<Tab>"]     = function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end,
    ["<S-Tab>"]   = function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end,
    ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
    ["<C-f>"]     = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"]     = cmp.mapping.close(),
    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
  })
end
return M
