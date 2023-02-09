require("dashboard").setup({
	theme = "hyper",
	config = {
		--  ANSI Shadow font is used for header
		header = {
			"███╗   ██╗██╗   ██╗██████╗  █████╗  ██████╗██╗  ██╗",
			"████╗  ██║██║   ██║██╔══██╗██╔══██╗██╔════╝██║ ██╔╝",
			"██╔██╗ ██║██║   ██║██████╔╝███████║██║     █████╔╝ ",
			"██║╚██╗██║╚██╗ ██╔╝██╔═══╝ ██╔══██║██║     ██╔═██╗ ",
			"██║ ╚████║ ╚████╔╝ ██║     ██║  ██║╚██████╗██║  ██╗",
			"╚═╝  ╚═══╝  ╚═══╝  ╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝",
			"                                                   ",
		},
		-- shortcuts in the top page
		shortcut = {
			{ desc = " Update", group = "@property", action = "PackerSync", key = "u" },
			{
				desc = " Files",
				group = "Label",
				action = "Telescope find_files",
				key = "f",
			},
			{
				desc = "  New file",
				action = "enew",
				key = "e",
			},
			{
				desc = " Quit Nvim",
				action = "qa",
				key = "q",
			},
		},
	},
})
