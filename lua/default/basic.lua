-- local utf8 = require("utf8")
-- let g:do_filetype_lua = 1
-- Color themes
vim.opt.termguicolors = true
vim.opt.syntax="Enable"

vim.cmd[[
highlight NvimTreeFolderIcon guibg=blue
]]
--Disable wrapping line.
vim.cmd[[set nowrap]]
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

-- chack run Atom OneDark Theme
local status_ok, onedark = pcall(require, "onedark")

-- auto install Plugins and load theme 
if not status_ok then
    return
else
   onedark.load()
end


-- enable mouse support and clipboard(xsel or wl-clipboard(for wayland))
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.laststatus= 3 -- Status Line Mode
vim.opt.showtabline= 2 -- Tab Line Mode

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


