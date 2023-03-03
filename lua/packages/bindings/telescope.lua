local bind = vim.keymap.set

-- import trouble actions for telescope
local trouble = require("trouble.providers.telescope")
-- import telescope actions safely
local actions = require("telescope.actions")

-- telescopes
bind("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
bind("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
bind("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
bind("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
bind("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
-- telescope git commands
bind("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
bind("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
bind("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
bind("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

local binds = {
	mappings = {
		i = {
			["<C-t>"] = trouble.open_with_trouble,
			["<C-k>"] = actions.move_selection_previous, -- move to prev result
			["<C-j>"] = actions.move_selection_next, -- move to next result
			["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
		},
		n = { ["<C-t>"] = trouble.open_with_trouble },
	},
}
return binds
