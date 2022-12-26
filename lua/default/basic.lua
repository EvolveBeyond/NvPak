local set = vim.opt
local vimscript = vim.cmd

-- local utf8 = require("utf8")
-- let g:do_filetype_lua = 1

-- Color themes
set.termguicolors = true
set.syntax="Enable"

vimscript[[
highlight NvimTreeFolderIcon guibg=blue
]]
--Disable wrapping line.
vimscript[[set nowrap]]
-- Disable transparent Background
set.background = 'dark'
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

-- Folding
-- set.foldmethod='expr'
-- set.foldexpr='nvim_treesitter#foldexpr()'

-- chack run Atom OneDark Theme
local status_ok, onedark = pcall(require, "onedark")

-- auto install Plugins and load theme 
if not status_ok then
    return
else
   onedark.load()
end

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

set.laststatus= 3 -- Status Line Mode
set.showtabline= 2 -- Tab Line Mode

-- erorr and Warning managment
vim.diagnostic.config({
  virtual_text = false, -- Disable virtual_text since it's redundant due to lsp_lines.
  virtual_lines =
      {
        only_current_line = true,
        spacing = 5,
        severity_limit = 'Warning',
      }
                    })


