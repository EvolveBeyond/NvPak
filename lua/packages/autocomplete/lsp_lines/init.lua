return {
		url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = { "BufRead" },
		config = function()
			require("packages.autocomplete.lsp_lines.main")
		end,
	}
