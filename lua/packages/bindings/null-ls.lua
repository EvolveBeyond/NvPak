local bind = vim.keymap.set

-- auto format
bind("n", "<C-f>", ":lua vim.lsp.buf.formatting()<cr>", { silent = true })
