local set = vim.opt
local vimscript = vim.cmd

-- chack found themes
local themes_status = pcall(require, "dracula")

-- auto load theme
if themes_status then
	require("packages.colors.dracula")
end

set.syntax = "Enable"

vimscript([[
highlight NvimTreeFolderIcon guibg=NONE
]])
