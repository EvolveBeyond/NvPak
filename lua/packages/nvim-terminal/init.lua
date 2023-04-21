return {
		"s1n7ax/nvim-terminal",
		event = { "BufRead" },
		config = function()
			require("packages.nvim-terminal.main")
		end,
	}

