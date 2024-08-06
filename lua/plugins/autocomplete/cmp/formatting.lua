local function setup_formatting(cmp, lspkind, source_mapping)
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
					vim_item.kind = lspkind.presets.default[vim_item.kind]
					local menu = source_mapping[entry.source.name]
					vim_item.menu = menu
					return vim_item
				end,
			}),
		},
	})
end

return { setup_formatting = setup_formatting }
