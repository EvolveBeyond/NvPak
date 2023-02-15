local set = vim.opt
local vimscript = vim.cmd

-- chack found themes
local themes_status = pcall(require, "onedark")

-- auto load theme
if themes_status then
	require("colors.onedark")
end

set.termguicolors = true
set.syntax = "Enable"

vimscript([[
highlight NvimTreeFolderIcon guibg=NONE
]])
