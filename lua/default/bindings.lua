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


-- Debugin System
vim.keymap.set("","<Leader>l",require("lsp_lines").toggle,{ desc = "Toggle lsp_lines" })

-- Buffer manager
vim.keymap.set('n', '<Tab>', ':bn<CR>') -- Buffer Switch
vim.keymap.set('n', '<C-b>', ':bd<CR>') -- Buffer Close

-- Auto comment
vim.keymap.set('v', '<C-/>', ':s/^/#<CR>')

-- Save mode
vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('i',  'C-s',  ':w<CR>')

-- Nvim Terminal
terminal = require('nvim-terminal').DefaultTerminal;

local silent = { silent = true }

vim.api.nvim_set_keymap('n', '<leader>t', ':lua terminal:toggle()<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>1', ':lua terminal:open(1)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>2', ':lua terminal:open(2)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>3', ':lua terminal:open(3)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>1', ':lua NTGlobal["terminal"]:open(1)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>+', ':lua NTGlobal["window"]:change_height(2)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>-', ':lua NTGlobal["window"]:change_height(-2)<cr>', silent)

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
})
