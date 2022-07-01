-- Fire Explorer
vim.keymap.set('n', '<leader>r', ':NvimTreeRefresh<CR>') -- nnoremap <leader>r :NvimTreeRefresh<CR>
vim.keymap.set('n', '<leader>n', ':NvimTreeFindFile<CR>') -- nnoremap <leader>n :NvimTreeFindFile<CR> 
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>') -- nnoremap <C-n> :NvimTreeToggle<CR>

require'nvim-tree.config'.nvim_tree_callback{
veiw ={   
mappings = {
      custom_only = false,
      list = {
					{ key = {"<CL>", "q" }, action = "edit", mode = "n"},
        },
      },
    },
  }

-- Buffer manager
vim.keymap.set('n', '<Tab>', ':bn<CR>')

-- Save mode
vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('i',  'C-s',  ':w<CR>')



-- cmp autocompelet
local cmp = require('cmp')
cmp.setup({

  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    {name = 'buffer',
      -- Correct:
     option = {keyword_pattern = [[\k\+]],}
    },
    { name = 'cmdline'},
    { name = 'nvim_lsp_signature_help' },
  },

})
