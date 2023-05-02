local set = vim.opt
local vimscript = vim.cmd

-- chack found themes
local themes_status = pcall(require, "rose-pine")

-- auto load theme
if themes_status then
	require("packages.colors.rose-pine")
end

set.syntax = "Enable"

vimscript([[
highlight NvimTreeFolderIcon guibg=NONE
]])
