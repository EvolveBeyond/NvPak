local bind = vim.keymap.set
local NTerm = require("nvim-terminal")

terminal = NTerm.DefaultTerminal

bind("n", "<leader>t", ":lua terminal:toggle()<cr>", { silent = true })
bind("n", "<leader>1", ":lua terminal:open(1)<cr>", { silent = true })
bind("n", "<leader>2", ":lua terminal:open(2)<cr>", { silent = true })
bind("n", "<leader>3", ":lua terminal:open(3)<cr>", { silent = true })
bind("n", "<leader>1", ':lua NTGlobal["terminal"]:open(1)<cr>', { silent = true })
bind("n", "<leader>+", ':lua NTGlobal["window"]:change_height(2)<cr>', { silent = true })
bind("n", "<leader>-", ':lua NTGlobal["window"]:change_height(-2)<cr>', { silent = true })
