-- Keybindings - NvPak 2026
local bind = vim.keymap.set
vim.g.mapleader = " "

-- Basic navigation & files
bind("n", "<leader>w", ":w<CR>", { desc = "Save" })
bind("n", "<leader>q", ":q<CR>", { desc = "Quit" })
bind("n", "<Esc>", ":noh<CR>", { desc = "Clear highlights" })
bind("n", "<C-s>", ":w<CR>", { desc = "Save file" })
bind("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })

-- Buffer navigation
bind("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
bind("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
bind("n", "<C-b>", ":bd<CR>", { desc = "Close buffer" })

-- Window management
bind("n", "<C-h>", "<C-w>h", { desc = "Window left" })
bind("n", "<C-j>", "<C-w>j", { desc = "Window down" })
bind("n", "<C-k>", "<C-w>k", { desc = "Window up" })
bind("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- LSP navigation & actions
bind("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
bind("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
bind("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
bind("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
bind("n", "gr", vim.lsp.buf.references, { desc = "List references" })
bind("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
bind("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
bind("n", "<C-f>", function() vim.lsp.buf.format({ async = true }) end, { desc = "LSP format" })

-- Diagnostics
bind("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
bind("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
bind("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- Folding
bind("n", "<leader>f", "za", { desc = "Toggle fold" })

-- System clipboard
bind({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
bind("n", "<leader>p", "\"+p", { desc = "Paste from system clipboard" })

-- Persian (RTL) Toggle
bind("n", "<leader>rtl", function()
    require("core.rtl").toggle()
end, { desc = "Toggle RTL mode" })

-- Terminal BiDi Toggle (Useful for Persian in terminals)
bind("n", "<leader>bd", function()
    vim.o.termbidi = not vim.o.termbidi
    print("termbidi: " .. tostring(vim.o.termbidi))
end, { desc = "Toggle termbidi" })
