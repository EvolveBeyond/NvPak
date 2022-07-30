-- local utf8 = require("utf8")
-- let g:do_filetype_lua = 1
-- Color themes
vim.opt.termguicolors = true
vim.opt.syntax="Enable"

vim.cmd[[
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

-- chack run Packer
local status_ok, packer = pcall(require, "packer")

-- auto install Plugins and load theme 
if not status_ok then
    return
else
	vim.cmd "colorscheme onedark"
end


-- enable mouse support and clipboard(xsel or wl-clipboard(for wayland))
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.laststatus= 3 -- Status Line Mode
vim.opt.showtabline= 2 -- Tab Line Mode
