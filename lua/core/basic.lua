-- Basic settings
local set = vim.o

set.termguicolors = true
set.number = true
set.relativenumber = true
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.signcolumn = "yes"
set.mouse = "a"
set.updatetime = 250
set.timeoutlen = 500
set.clipboard = "unnamedplus"

-- RTL & Persian Support (Konsole optimized)
set.termbidi = true
set.arabicshape = true

-- Native Folding
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldlevelstart = 99
