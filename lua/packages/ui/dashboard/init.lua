return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("packages.ui.dashboard.main")
	end,
	dependencies = "nvim-tree/nvim-web-devicons",
}
