local bind = vim.keymap.set

bind("n", "<leader>r", ":NvimTreeRefresh<CR>") -- nnoremap <leader>r :NvimTreeRefresh<CR>
bind("n", "<leader>n", ":NvimTreeFindFile<CR>") -- nnoremap <leader>n :NvimTreeFindFile<CR>
bind("n", "<C-n>", ":NvimTreeToggle<CR>") -- nnoremap <C-n> :NvimTreeToggle<CR>

local view = {
	endveiw = {
		mappings = {
			custom_only = false,
			list = {
				{ key = { "<CL>", "q" }, action = "edit", mode = "n" },
			},
		},
	},
}
return view
