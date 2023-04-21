local bind = vim.keymap.set
local nvim_tree = require("nvim-tree")

bind("n", "<leader>r", ":NvimTreeRefresh<CR>") -- nnoremap <leader>r :NvimTreeRefresh<CR>
bind("n", "<leader>n", ":NvimTreeFindFile<CR>") -- nnoremap <leader>n :NvimTreeFindFile<CR>
bind("n", "<C-n>", ":NvimTreeToggle<CR>") -- nnoremap <C-n> :NvimTreeToggle<CR>

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
	local node = nvim_tree.get_node_at_cursor()
	if node and node.type == "file" then
		vim.cmd("tabnew " .. node.absolute_path)
	end
end

local view = {
	endveiw = {
		mappings = {
			custom_only = false,
			list = {
				{ key = { "<CL>", "q" }, action = "edit", mode = "n" },
				{ key = { "<CR>", "o" }, cb = "open_tree" },
				{ key = "cd", cb = "cd_to_directory" },
			},
		},
	},
}
return view
