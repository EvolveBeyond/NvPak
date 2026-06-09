return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPre" },
	config = function()
		require("packages.ui.HexColor.main")
	end,
}
