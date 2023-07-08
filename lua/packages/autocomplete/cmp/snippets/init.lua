return {
	"L3MON4D3/LuaSnip",
	dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
	build = "make install_jsregexp",
	config = function()
		require("packages.autocomplete.cmp.snippets.main")
	end,
}
