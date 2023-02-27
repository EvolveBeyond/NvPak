local bind = vim.keymap.set

-- auto format
bind("n", "<leader>f", ":lua vim.lsp.buf.formatting()<cr>", { silent = true })
