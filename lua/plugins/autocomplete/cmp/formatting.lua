local function setup_formatting(cmp, lspkind)
  cmp.setup({
    formatting = {
      fields = {
        cmp.ItemField.Abbr,  -- abbreviation (text of the completion)
        cmp.ItemField.Kind,  -- icon for the completion kind
        cmp.ItemField.Menu,  -- source of the completion
      },
      format = lspkind.cmp_format({
        mode = "symbol_text",  -- mode for formatting (e.g., symbol + text)
        maxwidth = 40,  -- max width of the completion item
        before = function(entry, vim_item)
          local source_mapping = {
            nvim_lsp = "[LSP]",
            spell = "[SPL]",
            dictionary = "[DCT]",
            path = "[FIL]",
            luasnip = "[SNP]",
            buffer = "[BUF]",
          }

          -- Adjust the completion icon based on the item type (kind)
          vim_item.kind = lspkind.presets.default[vim_item.kind] or vim_item.kind

          -- Set the menu label based on the source of the completion
          vim_item.menu = source_mapping[entry.source.name] or ""

          return vim_item
        end,
      }),
    },
  })
end

return { setup_formatting = setup_formatting }
