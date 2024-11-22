local set = vim.o
local vimscript = vim.cmd

-- Basic settings for encoding and font
set.encoding = "UTF-8"
set.fileencoding = "UTF-8"
set.guifont = "JetBrainsMono Nerd Font Propo:h9"

-- Neovide-specific settings (if using Neovide)
if vim.g.neovide then
	set.neovide_padding_top = 0
	set.neovide_padding_bottom = 0
	set.neovide_padding_right = 0
	set.neovide_padding_left = 0
	set.neovide_floating_blur_amount_x = 2.0
	set.neovide_floating_blur_amount_y = 2.0
	-- set.neovide_transparency = 0.66
	set.neovide_refresh_rate = 60
	set.neovide_refresh_rate_idle = 5
	set.neovide_cursor_antialiasing = true
	set.neovide_cursor_animate_in_insert_mode = true
	set.neovide_cursor_animate_command_line = true
end

-- General visual settings
set.termguicolors = true  -- Enable true color support
set.laststatus = 3        -- Always show status line
set.showtabline = 2       -- Always show tab line
vimscript([[set nowrap]]) -- Disable line wrapping

-- Line number settings
set.number = true
set.relativenumber = true

-- Window splitting settings
set.splitbelow = true     -- Horizontal splits open below
set.splitright = true     -- Vertical splits open to the right

-- Tab settings
set.tabstop = 4           -- Set tab width to 4 spaces
set.shiftwidth = 4        -- Indentation width is 4 spaces
set.softtabstop = 4       -- Use spaces instead of tabs
set.expandtab = true      -- Expand tabs into spaces

-- Sign column always visible
set.signcolumn = "yes"

-- Folding (using Treesitter-based folding if enabled)
-- Uncomment these lines if using Treesitter folding
-- set.foldmethod='expr'
-- set.foldexpr='nvim_treesitter#foldexpr()'

-- Enable mouse and clipboard support
set.clipboard = "unnamedplus"  -- Use system clipboard
set.mouse = "a"                -- Enable mouse support for all modes

-- Restore cursor position when reopening files
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})

-- Search settings
set.ignorecase = true           -- Ignore case in search
set.smartcase = true            -- Override ignorecase if search pattern contains uppercase

-- Better performance by limiting undo history size
set.undolevels = 1000           -- Set maximum undo levels to 1000
set.undodir = vim.fn.stdpath("state") .. "/undo"  -- Set undo directory to use persistent storage

-- Display line length marker
set.colorcolumn = "80"          -- Show a vertical line at column 80 for long lines
