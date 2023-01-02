local found_cmp, cmp = pcall(require,'cmp')
local found_lspkind, lspkind = pcall(require, 'lspkind')
local found_luasnip, luasnip = pcall(require, 'luasnip')
local found_tabnine_compare, tabnine_compare = pcall(require, 'cmp_tabnine.compare')
local found_tabnine_config, tabnine_config = pcall(require, 'cmp_tabnine.config')
local found_compare, compare = pcall(require, 'cmp.config.compare')

if found_cmp and found_lspkind  and found_luasnip and found_tabnine_config and found_tabnine_compare and found_compare then

tabnine_config:setup({
	max_lines = 1000;
	max_num_results = 20;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = {
        -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
	show_prediction_strength = true;
})


local source_mapping = {
              buffer = "[Txnt]",
	          nvim_lsp = "[LSP]",
	          cmp_tabnine = "[TN]",
	          path = "[Path]",
              luasnip = "[Snp]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Ltx]",
                        }


    cmp.setup({
            snippet = {
            expand = function(args)
                -- vim.fn['UltiSnips#Anon'](args.body)
                luasnip.lsp_expand(args.body)
            end
                       },
            window = {
                       completion = cmp.config.window.bordered(),
                       documentation = cmp.config.window.bordered(),
                      },
           sources = {
                     { name = 'nvim_lsp' },
                     { name = 'luasnip' },
                     { name = 'buffer' },
                     { name = 'path' },
                     { name = 'cmp_tabnine' },
                     { name = 'nvim_lsp_signature_help' }, -- nvim-cmp source for displaying function signatures with the current parameter
                      },
          formatting = {
              fields = {
                      cmp.ItemField.Abbr,
                      cmp.ItemField.Kind,
                      cmp.ItemField.Menu,
                                },
          sorting = {
              priority_weight = 2,
                     comparators = {
                     tabnine_compare,
                     compare.offset,
                     compare.exact,
                     compare.score,
                     compare.recently_used,
                     compare.kind,
                     compare.sort_text,
                     compare.length,
                     compare.order,
                                  },
                    },
format = lspkind.cmp_format({
            mode = "symbol_text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
            maxwidth = 40, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                        vim_item.kind = lspkind.presets.default[vim_item.kind]

                        local menu = source_mapping[entry.source.name]
                        if entry.source.name == "cmp_tabnine" then
                          if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                            menu = entry.completion_item.data.detail .. " " .. menu
                          end
                          vim_item.kind = ""
                        end

                        vim_item.menu = menu

                        return vim_item
                      end,
                          }),

          experimental = {
              native_menu = false,
              ghost_text = true
                         },
                        },
})


-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  }, {
    { name = 'buffer' }
  })
})
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

end

vim.cmd[[
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#2A8
highlight! CmpItemAbbrMatch guibg=NONE guifg=#869CD6
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CB8
highlight! CmpItemKindVariable guibg=NONE guifg=#50BCaa
highlight! CmpItemKindInterface guibg=NONE guifg=#50FCAA
highlight! CmpItemKindText guibg=NONE guifg=#50BCaa
highlight! CmpItemKindFunction guibg=NONE guifg=#FCCFC6
highlight! CmpItemKindMethod guibg=NONE guifg=#CFFCF9
" front
highlight! CmpItemKindKeyword guibg=NONE guifg=#FFFFFF
highlight! CmpItemKindProperty guibg=NONE guifg=#FFFFFF
highlight! CmpItemKindUnit guibg=NONE guifg=#FFFFFF
]]
