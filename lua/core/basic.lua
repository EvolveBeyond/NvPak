-- Local variables for cleaner access to vim options and commands
local set = vim.o
local vimscript = vim.cmd

-- Encoding settings
set.encoding = "UTF-8"          -- Set general encoding to UTF-8
set.fileencoding = "UTF-8"     -- Set file encoding to UTF-8 for consistent file handling

-- Font settings for GUI environments (e.g., Neovide)
set.guifont = "FantasqueSansMono Nerd Font Mono:h9" -- Default font for GUI, supports Nerd Fonts for icons

-- Neovide-specific settings for enhanced GUI experience
if vim.g.neovide then
    set.neovide_padding_top = 10          -- Add padding for better readability
    set.neovide_padding_bottom = 10       -- Consistent padding for bottom
    set.neovide_padding_right = 10        -- Padding for right side
    set.neovide_padding_left = 10         -- Padding for left side
    set.neovide_floating_blur_amount_x = 2.0 -- Horizontal blur for floating windows
    set.neovide_floating_blur_amount_y = 2.0 -- Vertical blur for floating windows
    set.neovide_transparency = 0.9        -- Slight transparency for visual appeal
    set.neovide_refresh_rate = 75         -- Higher refresh rate for smoother animations
    set.neovide_refresh_rate_idle = 5     -- Lower refresh rate when idle to save resources
    set.neovide_cursor_antialiasing = true -- Smooth cursor rendering
    set.neovide_cursor_animate_in_insert_mode = true -- Animate cursor in insert mode
    set.neovide_cursor_animate_command_line = true -- Animate cursor in command line
    set.neovide_scroll_animation_length = 0.3 -- Smooth scroll animation duration
end

-- Terminal settings for color and UI
set.termguicolors = true       -- Enable true color support for better visuals
set.laststatus = 3             -- Always show status line (global status line)
set.showtabline = 2            -- Always show tabline with all tabs

-- Line wrapping and numbering
vimscript([[set nowrap]])      -- Disable line wrapping for cleaner code display
set.number = true              -- Show absolute line numbers
set.relativenumber = true      -- Show relative line numbers for easier navigation

-- Window splitting behavior
set.splitbelow = true          -- Open new splits below the current window
set.splitright = true          -- Open new splits to the right of the current window

-- Tab and indentation settings
set.tabstop = 4                -- Set tab width to 4 spaces
set.shiftwidth = 4             -- Set indentation width to 4 spaces
set.softtabstop = 4            -- Ensure consistent editing with 4 spaces
set.expandtab = true           -- Convert tabs to spaces

-- Sign column for diagnostics and plugins
set.signcolumn = "yes"         -- Always show sign column for diagnostics/icons

-- Code folding using treesitter for better accuracy
set.foldmethod = "expr"                   -- Use expression-based folding
set.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folding logic
set.foldlevelstart = 99                   -- Start with all folds open by default

-- Clipboard and mouse integration
set.clipboard = "unnamedplus"  -- Sync Neovim clipboard with system clipboard
set.mouse = "a"                -- Enable mouse support in all modes

-- Restore cursor position when reopening files
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false) -- Restore cursor to last known position
    end,
})

-- Performance optimizations
set.updatetime = 250           -- Faster update time for responsiveness (e.g., swap file, cursor hold)
set.timeoutlen = 500           -- Shorter timeout for key combinations to improve responsiveness

