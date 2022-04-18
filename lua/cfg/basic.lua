local set = vim.opt

-- local utf8 = require("utf8")
-- let g:do_filetype_lua = 1

-- Color themes           
set.termguicolors = true
vim.cmd [[ 
colorscheme dracula
syntax enable
]]
-- Disable transparent Background
set.background = 'dark'           
-- Show current line number
set.number = true                    
-- Show relative line numbers
set.relativenumber = true            
set.splitbelow = true
set.splitright = true
set.clipboard = "unnamedplus"
set.mouse = "a"
-- Tab set to two spaces
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
-- Folding
set.foldmethod='expr'
set.foldexpr='nvim_treesitter#foldexpr()'