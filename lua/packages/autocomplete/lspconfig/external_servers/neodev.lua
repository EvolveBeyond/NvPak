require("neodev").setup({
	library = {
		enabled = true,
		runtime = true,
		types = true,
		plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim", "nvim-dap-ui" },
	},
	setup_jsonls = true,
	lspconfig = true,
	-- These options are not enabled, but can be enabled in some cases. Add comments to explain them.
	plugins = true,
	-- override = function(root_dir, options) end,
	-- pathStrict = true,
})
