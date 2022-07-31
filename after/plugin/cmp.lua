local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')
local tabnine = require('cmp_tabnine.config')


tabnine:setup({
	max_lines = 1000;
	max_num_results = 20;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
	show_prediction_strength = false;
})



local source_mapping = {
              buffer = "[Txt]",
	            nvim_lsp = "[LSP]",
	            cmp_tabnine = "[TN]",
	            path = "[Path]",
              luasnip = "[Snp]",
              vsnip = "[VSp]",
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
                     { name = 'vsnip' },
                     { name = 'buffer' },
                     { name = 'path' },
                     { name = 'cmp_tabnine' },
                      },
          formatting = {
              fields = {
                      cmp.ItemField.Abbr,
                      cmp.ItemField.Kind,
                      cmp.ItemField.Menu,
                                },
format = lspkind.cmp_format({
            mode = "text", -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
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
    sources = {
      { name = 'buffer' }
    }
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
