return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufRead" },
	config = function()
		require("packages.nvim-treesitter.indent.main")
	end,
}
