local bind = vim.keymap.set

bind("n", "<leader>t", function() require("snacks").terminal() end, { silent = true })
