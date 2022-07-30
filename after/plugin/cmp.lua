local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')


local function feedkey(key, mode)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(key, true, true, true),
    mode, true)
end

-- Tabnine setup
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
              buffer = "[Buf]",
	            nvim_lsp = "[LSP]",
	            cmp_tabnine = "[TN]",
	            path = "[Path]",
              luasnip = "[Snp]",
              vsnip = "[VSp]",
              nvim_lua = "[Lua]",
              latex_symbols = "[Ltx]",
                        }


    cmp.setup {
            snippet = {
            expand = function(args)
                vim.fn['UltiSnips#Anon'](args.body)
            end
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
               format = function(entry, vim_item)
               vim_item.kind = lspkind.presets.default[vim_item.kind]
               local menu = source_mapping[entry.source.name]
               if entry.source.name == 'cmp_tabnine' then
                 if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
                     menu = entry.completion_item.data.detail .. ' ' .. menu
                 end
                 vim_item.kind = ''
               end
               vim_item.menu = menu
               return vim_item
            end
         },
          experimental = {
              native_menu = false,
              ghost_text = true
                         }
        }


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
