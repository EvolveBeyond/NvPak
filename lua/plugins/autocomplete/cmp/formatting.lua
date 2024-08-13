local function setup_formatting(cmp, lspkind)
    cmp.setup({
        formatting = {
            fields = {
                cmp.ItemField.Abbr,
                cmp.ItemField.Kind,
                cmp.ItemField.Menu,
            },
            format = lspkind.cmp_format({
                mode = "symbol_text",
                maxwidth = 40,
                before = function(entry, vim_item)
                    local source_mapping = {
                        nvim_lsp = "[LSP]",
                        spell = "[SPL]",
                        dictionary = "[DCT]",
                        path = "[FIL]",
                        luasnip = "[SNP]",
                        buffer = "[BUF]",
                    }

                    -- Use `kind` to set the appropriate icon
                    vim_item.kind = lspkind.presets.default[vim_item.kind] or vim_item.kind
                    -- Set the menu text based on the source
                    vim_item.menu = source_mapping[entry.source.name] or ""

                    return vim_item
                end,
            }),
        },
    })
end

return { setup_formatting = setup_formatting }
