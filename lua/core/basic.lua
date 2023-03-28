local set = vim.opt
local vimscript = vim.cmd

set.encoding = "UTF-8"
set.fileencoding = "UTF-8"

set.laststatus = 3 -- Status Line Mode
set.showtabline = 2 -- Tab Line Mode with all tabs shown
--Disable wrapping line.
vimscript([[set nowrap]])
-- Show current line number
set.number = true
-- Show relative line numbers
set.relativenumber = true
set.splitbelow = true
set.splitright = true
-- Tab set to two spaces
set.tabstop = 4
set.shiftwidth = 0
set.softtabstop = 0
set.expandtab = true
set.signcolumn = "yes"

-- Folding
-- set.foldmethod='expr'
-- set.foldexpr='nvim_treesitter#foldexpr()'

-- enable mouse support and clipboard(xsel or wl-clipboard(for wayland))
set.clipboard = "unnamedplus"
set.mouse = "a"
-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})


