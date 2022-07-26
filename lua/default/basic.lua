-- local utf8 = require("utf8")
-- let g:do_filetype_lua = 1


-- chack run Packer
local status_ok, packer = pcall(require, "packer")

-- auto install Plugins and load theme 
if not status_ok then
    return
else
    require("usercustom.usercfg")
end


-- enable mouse support and clipboard(xsel or wl-clipboard(for wayland))
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.laststatus= 3 -- Status Line Mode
vim.opt.showtabline= 2 -- Tab Line Mode
