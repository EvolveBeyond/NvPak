-- Color themes
vim.opt.termguicolors = true
vim.cmd[[
colorscheme onedark
syntax enable
highlight NvimTreeFolderIcon guibg=blue
]]
-- Disable transparent Background
vim.opt.background = 'dark'
-- Show current line number
vim.opt.number = true
-- Show relative line numbers
vim.opt.relativenumber = true
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Tab set to two spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Folding
-- vim.opt.foldmethod='expr'
-- vim.opt.foldexpr='nvim_treesitter#foldexpr()'

