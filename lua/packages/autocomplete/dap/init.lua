return {
	"jay-babu/mason-nvim-dap.nvim",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("packages.dap")
	end,
	ft = { "python", "rust", "lua" },
}
