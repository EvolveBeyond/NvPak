local set = vim.opt
local vimscript = vim.cmd

-- chack found themes
local themes_status = pcall(require, "catppuccin")

-- auto load theme
if themes_status then
	require("colors.catppuccin")
end

set.termguicolors = true
set.syntax = "Enable"

vimscript([[
highlight NvimTreeFolderIcon guibg=NONE
]])
