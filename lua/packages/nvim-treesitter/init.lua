return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPre",
	build = ":TSUpdate",
	config = function()
		require("packages.nvim-treesitter.main")
	end,
}
