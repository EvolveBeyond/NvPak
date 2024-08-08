-- import telescope plugin safely
local telescope = require("telescope")
local theme = require("telescope.themes")
-- Bindings
local hotkeys = require("plugins.ui.telescope.bind")

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
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        },
    },
})

telescope.load_extension('fzy_native')
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("ui-select")
-- telescope notify plugin
telescope.load_extension("notify")
