-- Packer 
require('plugins')

-- Basic Config Fils
require('cfg.basic')

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

-- StatusLine
require("cfg.staline")


-- Bindings
require("cfg.bindings")

