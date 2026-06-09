local bind    = vim.keymap.set
local set     = vim.g

-- Leader key
set.mapleader = " "

-- ─────────────────────────────────────────────────────────────────────────────
-- Buffer navigation
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
bind("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
bind("n", "<C-b>", ":bd<CR>", { desc = "Close buffer" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Comment in visual mode
-- ─────────────────────────────────────────────────────────────────────────────
bind("v", "<C-/>", ":s/^/\\/\\//<CR>", { desc = "Comment selected lines" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Save file
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<C-s>", ":w<CR>", { desc = "Save file" })
bind("i", "<C-s>", "<Esc>:w<CR>i", { desc = "Save in insert mode" })

-- ─────────────────────────────────────────────────────────────────────────────
-- LSP formatting
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<C-f>", function()
        vim.lsp.buf.format({ async = true })
    end,
    { silent = true, desc = "LSP format buffer" }
)

-- ─────────────────────────────────────────────────────────────────────────────
-- Clear search highlights
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<leader>/", "<Cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Toggle settings
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<leader>rl", function() -- toggle relative numbers
        vim.wo.relativenumber = not vim.wo.relativenumber
    end,
    { desc = "Toggle relative line numbers" }
)
bind("n", "<leader>ss", ":set spell!<CR>", { desc = "Toggle spell check" })
bind("n", "<leader>pp", ":set paste!<CR>", { desc = "Toggle paste mode" })
bind("n", "<leader>ww", ":set wrap!<CR>", { desc = "Toggle wrap" })
bind("n", "<leader>wl", ":set list!<CR>", { desc = "Toggle listchars" })

-- ─────────────────────────────────────────────────────────────────────────────
-- LSP navigation & actions
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "gD", vim.lsp.buf.declaration, { noremap = true, silent = true, desc = "Go to declaration" })
bind("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
bind("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Hover documentation" })
bind("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true, desc = "Go to implementation" })
bind("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "List references" })
bind("n", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename symbol" })
bind("n", "<leader>ca", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code action" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Diagnostics
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
bind("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })
bind("n", "<leader>e", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "Show diagnostic" })
bind("n", "<leader>q", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "Diagnostics to loclist" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Window management
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<C-h>", "<C-w>h", { desc = "Window left" })
bind("n", "<C-j>", "<C-w>j", { desc = "Window down" })
bind("n", "<C-k>", "<C-w>k", { desc = "Window up" })
bind("n", "<C-l>", "<C-w>l", { desc = "Window right" })
bind("n", "<leader><", "<cmd>vertical resize -2<CR>", { desc = "Vertical shrink" })
bind("n", "<leader>>", "<cmd>vertical resize +2<CR>", { desc = "Vertical enlarge" })
bind("n", "<leader>-", "<cmd>resize -2<CR>", { desc = "Horizontal shrink" })
bind("n", "<leader>+", "<cmd>resize +2<CR>", { desc = "Horizontal enlarge" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Folding
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<leader>f", "za", { desc = "Toggle fold" })
bind("n", "<leader>F", function() -- close all folds
        vim.cmd("normal! zM")
    end,
    { desc = "Close all folds" }
)
bind("n", "<leader>O", function() -- open all folds
        vim.cmd("normal! zR")
    end,
    { desc = "Open all folds" }
)

-- ─────────────────────────────────────────────────────────────────────────────
-- Centered search navigation
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "n", "nzz", { desc = "Next search (centered)" })
bind("n", "N", "Nzz", { desc = "Previous search (centered)" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Quickfix & Location list
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<leader>cn", "<cmd>cnext<CR>", { desc = "Next quickfix" })
bind("n", "<leader>cp", "<cmd>cprev<CR>", { desc = "Previous quickfix" })
bind("n", "<leader>co", "<cmd>copen<CR>", { desc = "Open quickfix" })
bind("n", "<leader>cc", "<cmd>cclose<CR>", { desc = "Close quickfix" })
bind("n", "<leader>ln", "<cmd>lnext<CR>", { desc = "Next loclist" })
bind("n", "<leader>lp", "<cmd>lprev<CR>", { desc = "Previous loclist" })
bind("n", "<leader>lo", "<cmd>lopen<CR>", { desc = "Open loclist" })
bind("n", "<leader>lc", "<cmd>lclose<CR>", { desc = "Close loclist" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Marks
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<leader>m,", "`,", { desc = "Jump to previous mark (exact)" })
bind("n", "<leader>m;", "''", { desc = "Jump to previous mark (line)" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Macros
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<leader>rq", "q", { desc = "Start/stop macro recording" })
bind("n", "<leader>@", "@q", { desc = "Play macro q" })

-- ─────────────────────────────────────────────────────────────────────────────
-- System clipboard
-- ─────────────────────────────────────────────────────────────────────────────
bind({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank to system clipboard" })
bind("n", "<leader>Y", "\"+Y", { desc = "Yank line to clipboard" })
bind("n", "<leader>p", "\"+p", { desc = "Paste from system clipboard" })

-- ─────────────────────────────────────────────────────────────────────────────
-- Search & replace
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace word under cursor" })
bind("v", "<leader>sr", ":s/", { desc = "Replace selection" })

-- ─────────────────────────────────────────────────────────────────────────────
-- File browser (netrw)
-- ─────────────────────────────────────────────────────────────────────────────
bind("n", "<leader>pv", ":Ex<CR>", { desc = "Open file browser" })
