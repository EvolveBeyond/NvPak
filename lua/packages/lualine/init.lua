return {
		"nvim-lualine/lualine.nvim",
		event = { "VimEnter" },
		config = function()
			require("packages.lualine.main")
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"linrongbin16/lsp-progress.nvim",
		},
	}


