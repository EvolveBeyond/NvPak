local bind = vim.keymap.set
local nvim_tree = require("nvim-tree")

-- Define key mappings for nvim-tree actions
bind("n", "<leader>r", ":NvimTreeRefresh<CR>")  -- Refresh the file tree
bind("n", "<leader>n", ":NvimTreeFindFile<CR>")  -- Find the current file in the tree
bind("n", "<C-n>", ":NvimTreeToggle<CR>")  -- Toggle NvimTree visibility

-- Define helper functions
local function is_directory(file)
	return vim.fn.isdirectory(file) == 1
end

local function cd_to_directory(file)
	if is_directory(file) then
    vim.cmd("e " .. file)  -- Opens the directory in the current buffer
  else
    print("Not a directory")
	end
end

local function open_tree()
	local node = nvim_tree.get_node_at_cursor()
	if node and node.type == "file" then
    local file_path = node.absolute_path
    if vim.fn.filereadable(file_path) == 1 then
      vim.cmd("edit " .. file_path)
    else
      print("File does not exist or is not readable.")
    end
	end
end

-- Mappings for nvim-tree
local view = {
		mappings = {
			custom_only = false,
			list = {
				{ key = { "<CL>", "q" }, action = "edit", mode = "n" },
      { key = { "<CR>", "o" }, cb = open_tree },
      { key = "cd", cb = cd_to_directory },
		},
	},
}

return view
