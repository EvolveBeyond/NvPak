-- local utf8 = require("utf8")
-- let g:do_filetype_lua = 1

-- packer_bootstrap Finder
local fn = vim.fn
local packer_bootstrap = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- auto install Plugins and load theme 
if fn.empty(fn.glob(packer_bootstrap)) == 0 then
  if require("packer") then  
    require("packer").install()
    require("usercustom.usercfg")
  else
  vim.cmd 'q'
  end
end
-- enable mouse support and clipboard(xsel or wl-clipboard(for wayland))
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.laststatus= 3 -- Status Line Mode
vim.opt.showtabline= 2 -- Tab Line Mode
