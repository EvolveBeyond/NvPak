-- Basic settings - NvPak 2026
local set = vim.o

-- Encoding settings
set.encoding = "UTF-8"
set.fileencoding = "UTF-8"

-- Font settings for GUI
set.guifont = "Vazirmatn RD Nerd Font:h11" -- Persian-friendly Nerd Font

-- Neovide-specific settings
if vim.g.neovide then
    set.neovide_padding_top = 10
    set.neovide_padding_bottom = 10
    set.neovide_padding_right = 10
    set.neovide_padding_left = 10
    set.neovide_transparency = 0.9
    set.neovide_refresh_rate = 75
    set.neovide_cursor_antialiasing = true
end

-- UI Settings
set.termguicolors = true
set.laststatus = 3
set.showtabline = 2
set.number = true
set.relativenumber = true
set.signcolumn = "yes"
set.mouse = "a"
set.updatetime = 250
set.timeoutlen = 500
set.clipboard = "unnamedplus"
set.wrap = false -- Disable line wrapping by default

-- Tabs & Indentation
set.tabstop = 4
set.shiftwidth = 4
set.expandtab = true
set.splitbelow = true
set.splitright = true

-- Persian (RTL) & BiDi support
set.termbidi = true
set.arabicshape = true

-- Modern Folding (Neovim 0.10+)
set.foldmethod = "expr"
set.foldexpr = "v:lua.vim.treesitter.foldexpr()"
set.foldlevelstart = 99

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})
