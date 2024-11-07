local function setup_snippet(cmp, luasnip)
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
  })
end

return { setup_snippet = setup_snippet }
