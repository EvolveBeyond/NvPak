return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNew" },
	dependencies = {
		"williamboman/mason.nvim",
		"jose-elias-alvarez/null-ls.nvim",
	},
	config = function()
		require("packages.autocomplete.null-ls.main")
	end,
}
