-- Packer
require('plugins')

-- Basic Config Fils
require('default.basic')

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


-- bracket autocompletion
require("default.AutoPairs")
require("default.ts-autotag")

-- snippets
require("default.luasnip")

-- File explorer
require("default.tree")

-- nvim terminal
require("default.NTerm")

-- Colors and themes
require("default.colorizer")

-- StatusLine
require("default.staline")

-- TabLine 
require("default.barbar")

-- Bindings
require("default.bindings")

-- user configs
require("userinit")
