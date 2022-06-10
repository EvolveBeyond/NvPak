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
