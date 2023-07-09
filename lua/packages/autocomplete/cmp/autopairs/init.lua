return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		require("packages.autocomplete.cmp.autopairs.main")
	end,
}
