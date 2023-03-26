local lsp_notify = require("lsp-notify")

lsp_notify.setup({
	icons = {
		spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }, -- `= false` to disable only this icon
		done = "!", -- `= false` to disable only this icon
	},
})

