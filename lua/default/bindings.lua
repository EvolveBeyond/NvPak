local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local silent = { silent = true }


local ok ,cmp = pcall(require, 'cmp')


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


vim.api.nvim_set_keymap('n', '<leader>t', ':lua terminal:toggle()<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>1', ':lua terminal:open(1)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>2', ':lua terminal:open(2)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>3', ':lua terminal:open(3)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>1', ':lua NTGlobal["terminal"]:open(1)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>+', ':lua NTGlobal["window"]:change_height(2)<cr>', silent)
vim.api.nvim_set_keymap('n', '<leader>-', ':lua NTGlobal["window"]:change_height(-2)<cr>', silent)

-- cmp autocompelet
if ok then
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
end
-- barbar tabline manager
-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
