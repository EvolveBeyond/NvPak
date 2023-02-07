local set = vim.g
local nvim_tree = require("nvim-tree")

local function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end

local options = {
	filters = {
		dotfiles = true,
	},
	hijack_cursor = true,
	update_focused_file = {
		enable = true,
	},
	view = {
		adaptive_size = true,
		side = "left",
		width = 25,
		hide_root_folder = true,
	},
	git = {
		enable = true,
		ignore = false,
	},
	filesystem_watchers = {
		enable = true,
	},
	actions = {
		open_file = {
			resize_window = true,
		},
	},
	renderer = {
		highlight_git = true,
		highlight_opened_files = "none",

		indent_markers = {
			enable = false,
		},

		icons = {
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},

			glyphs = {
				default = "",
				symlink = "",
				folder = {
					default = "",
					empty = "",
					empty_open = "",
					open = "",
					symlink = "",
					symlink_open = "",
					arrow_open = "",
					arrow_closed = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
}

-- git config
set.nvim_tree_git_hl = 1
set.nvimt_ree_show_icons = {
	git = 0,
	folders = 1,
	files = 1,
}
-- customize icons
set.nvim_tree_icons = options.glyphs
-- check for any override
set.nvim_tree_side = options.view.side
-- nvim_tree startup config
nvim_tree.setup(options)
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
