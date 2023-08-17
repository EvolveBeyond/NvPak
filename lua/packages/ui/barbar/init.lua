return {
	"romgrk/barbar.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("packages.ui.barbar.main")
	end,
}
