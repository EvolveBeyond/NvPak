return {
		"folke/trouble.nvim",
		event = { "BufRead" },
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("packages.trouble.main")
		end,
	}
