require("dashboard").setup({
	theme = "hyper",
	config = {
		--  ANSI Shadow font is used for header
		header = {
			"███╗   ██╗██╗   ██╗██████╗  █████╗ ██╗  ██╗",
			"████╗  ██║██║   ██║██╔══██╗██╔══██╗██║ ██╔╝",
			"██╔██╗ ██║██║   ██║██████╔╝███████║█████╔╝ ",
			"██║╚██╗██║╚██╗ ██╔╝██╔═══╝ ██╔══██║██╔═██╗ ",
			"██║ ╚████║ ╚████╔╝ ██║     ██║  ██║██║  ██╗",
			"╚═╝  ╚═══╝  ╚═══╝  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝",
		},
		-- shortcuts in the top page
		shortcut = {
			{ desc = " Update", action = "Rocks sync", key = "u" },
			{
				desc = " Files",
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
