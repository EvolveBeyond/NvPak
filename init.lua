-- Packer
require('plugins')

-- Basic Config Fils
require('default.basic')

-- dashboard
require("default.dashbord")

-- This plugin does several things to speed loading Lua modules and files.
require('impatient')

-- Treesitter
require('default.treesitter')

-- Auto-complete Cmp with the help of tabnine or LSP
require("default.lsp-zero")
require("default.cmp")
require("default.figget")
require("default.rust-tools")
-- require("default.tabnine")

-- File explorer
require("default.tree")

-- Colors and themes
require("default.colorizer")

-- StatusLine
require("default.staline")


-- Bindings
require("default.bindings")

