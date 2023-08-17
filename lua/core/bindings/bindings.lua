local bind = vim.keymap.set
local set = vim.g

-- Leader bind
set.mapleader = " "

-- Buffer manager
bind("n", "<Tab>", ":bn<CR>") -- Buffer Switch
bind("n", "<C-b>", ":bd<CR>") -- Buffer Close

-- Auto comment
bind("v", "<C-/>", ":s/^/#<CR>")

-- Save mode
bind("n", "<C-s>", ":w<CR>")
bind("i", "C-s", ":w<CR>")


-- auto format
bind("n", "<C-f>", ":lua vim.lsp.buf.format({ async = true})<cr>", { silent = true })
-- deselect on search
bind("n", "<leader>/", "<Cmd>noh<cr>", { silent = true})

