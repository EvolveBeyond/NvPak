-- import telescope plugin safely
local telescope = require("telescope")
local theme = require("telescope.themes")
-- Bindings
local hotkeys = require("packages.telescope.bind")

-- configure telescope
local mappings = hotkeys.mappings
telescope.setup({
	-- configure custom mappings
	defaults = {
		mappings,
	},
	extensions = {
		["ui-select"] = theme.get_dropdown({
			-- even more opts
		}),
	},
})

telescope.load_extension("fzf")
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("ui-select")
-- telescope notify plugin
telescope.load_extension("notify")
