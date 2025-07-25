local bind = vim.keymap.set

bind("n", "<leader>ff", function() require("snacks").picker.files() end) -- find files within current working directory, respects .gitignore
bind("n", "<leader>fs", function() require("snacks").picker.grep() end) -- find string in current working directory as you type
bind("n", "<leader>fc", function() require("snacks").picker.grep_word() end) -- find string under cursor in current working directory
bind("n", "<leader>fb", function() require("snacks").picker.buffers() end) -- list open buffers in current neovim instance
bind("n", "<leader>fh", function() require("snacks").picker.help() end) -- list available help tags
-- telescope git commands
bind("n", "<leader>gc", function() require("snacks").picker.git_log() end) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
bind("n", "<leader>gfc", function() require("snacks").picker.git_log_file() end) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
bind("n", "<leader>gb", function() require("snacks").picker.git_branches() end) -- list git branches (use <cr> to checkout) ["gb" for git branch]
bind("n", "<leader>gs", function() require("snacks").picker.git_status() end) -- list current changes per file with diff preview ["gs" for git status]
bind("n", "<leader>e", function() require("snacks").explorer() end)
