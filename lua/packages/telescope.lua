-- import telescope plugin safely
local telescope = require("telescope")
local theme = require("telescope.themes")
-- Bindings
local hotkeys = require("packages.bindings.telescope")

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
		hotkeys.mappings,
	},
	extensions = {
		["ui-select"] = {
			theme.get_dropdown({
				-- even more opts
			}),
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("flutter")
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("ui-select")
-- telescope notify plugin
telescope.load_extension("notify")
