return {
		"nvim-lualine/lualine.nvim",
		event = { "VimEnter" },
		config = function()
			require("packages.ui.lualine.main")
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"linrongbin16/lsp-progress.nvim",
		},
	}


