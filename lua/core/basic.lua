local set = vim.opt
local vimscript = vim.cmd

set.encoding = "UTF-8"
set.fileencoding = "UTF-8"

if vim.g.neovide then
	vim.o.guifont = "FantasqueSansMono Nerd Font Mono:h9"
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	-- vim.g.neovide_transparency = 0.66
	vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_animate_command_line = true
end

set.termguicolors = true
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
