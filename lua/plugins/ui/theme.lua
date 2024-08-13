local set = vim.o
local vimscript = vim.cmd

-- chack found themes
local themes_status = pcall(require, "nord")

-- auto load theme
if themes_status then
	require("plugins.ui.colors.nord")
end

set.syntax = "Enable"

vimscript([[
highlight NvimTreeFolderIcon guibg=NONE
]])
