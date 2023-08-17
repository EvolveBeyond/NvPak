return {
	"kyazdani42/nvim-tree.lua",
	event = { "VimEnter", "BufEnter" },
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("packages.ui.nvim-tree.main")
	end,
}
