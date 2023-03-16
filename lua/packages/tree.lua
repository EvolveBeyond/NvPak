local set = vim.g
local nvim_tree = require("nvim-tree")
local tree_binds = require("packages.bindings.tree")

-- Define helper functions
local function is_directory(file)
	return vim.fn.isdirectory(file) == 1
end

local function cd_to_directory(file)
	if is_directory(file) then
		vim.cmd.cd(file)
	end
end

local function open_tree()
	require("nvim-tree.api").tree.open()
end

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
		hide_root_folder = true,
		mappings = tree_binds.view,
	},
	git = { enable = true, ignore = false },
	filesystem_watchers = { enable = true },
	actions = { open_file = { resize_window = true } },
	renderer = {
		highlight_git = true,
		highlight_opened_files = "none",
		indent_markers = { enable = false },
		icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
	},
}

-- Set the icons and nvim_tree startup options
set_icons()
nvim_tree.setup(options)

-- Create autocmd to open nvim-tree if a directory is opened in a buffer
vim.cmd(
	[[autocmd BufWinEnter * if getftype(expand('%')) == 'directory' && !&buflisted | exe 'NvimTreeFindFile' expand('%') | wincmd p | ene | endif]]
)
