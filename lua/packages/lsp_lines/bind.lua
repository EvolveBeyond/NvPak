local bind = vim.keymap.set
local lsp_lines = require("lsp_lines")
-- Debugin System
bind("", "<Leader>l", lsp_lines.toggle, { desc = "Toggle lsp_lines" })
