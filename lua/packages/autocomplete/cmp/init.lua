return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-buffer",
		"f3fora/cmp-spell",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-document-symbol",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		{
			require("packages.autocomplete.cmp.snippets"),
		},
	},
	config = function()
		require("packages.autocomplete.cmp.main")
	end,
}
