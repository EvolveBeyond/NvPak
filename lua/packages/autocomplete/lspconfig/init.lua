return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNew" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		{
			"folke/neodev.nvim",
			config = function()
				require("packages.autocomplete.lspconfig.external_servers.neodev")
			end,
		},
	},
	config = function()
		require("packages.autocomplete.lspconfig.main")
	end,
}
