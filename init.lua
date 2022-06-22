-- Config Fils
require('cfg.basic')

-- Packer 
require('plugins')

-- This plugin does several things to speed loading Lua modules and files.
require('impatient')

-- Treesitter
require('cfg.treesitter')

-- Auto-complete Cmp with the help of tabnine or LSP
require("cfg.lsp-zero")
require("cfg.cmp")
require("cfg.figget")
require("cfg.rust-tools")

-- File explorer
require("cfg.tree")

-- Colors and themes
require("cfg.colorizer")

-- Bindings
require("cfg.bindings")

