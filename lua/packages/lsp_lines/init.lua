return {
		url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = { "BufRead" },
		config = function()
			require("packages.lsp_lines.main")
		end,
	}
