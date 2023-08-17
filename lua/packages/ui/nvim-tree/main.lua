local set = vim.g
local nvim_tree = require("nvim-tree")
local tree_binds = require("packages.ui.nvim-tree.bind")

local function set_icons()
	set.nvim_tree_icons = {
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
	}
end

-- Set global variables for nvim-tree
set.nvim_tree_git_hl = 1
set.nvim_tree_show_icons = { git = 0, folders = 1, files = 1 }

-- Set options for nvim-tree
local options = {
	filters = { dotfiles = true },
	hijack_cursor = true,
	update_focused_file = { enable = true },
	view = {
		adaptive_size = true,
		side = "left",
		width = 25,
		mappings = tree_binds.view,
	},
	git = { enable = true, ignore = false },
	filesystem_watchers = { enable = true },
	actions = { open_file = { resize_window = true } },
	renderer = {
		highlight_git = true,
		root_folder_label = false,
		highlight_opened_files = "none",
		indent_markers = { enable = false },
		icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
	},
}

-- Set the icons and nvim_tree startup options
set_icons()
nvim_tree.setup(options)
