return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("packages.autocomplete.dap.main")
	end,
	ft = { "python", "rust", "lua" },
}
