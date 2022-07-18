-- local utf8 = require("utf8")
-- let g:do_filetype_lua = 1

-- users configs
require("usercustom.usercfg")
-- enable mouse support and clipboard(xsel or wl-clipboard(for wayland))
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.laststatus= 3 -- Status Line Mode
vim.opt.showtabline= 2 -- Tab Line Mode

