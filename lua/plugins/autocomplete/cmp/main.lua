local cmp        = require("cmp")
local mapping    = require("plugins.autocomplete.cmp.mapping").setup_mapping(cmp)
local sources    = require("plugins.autocomplete.cmp.sources").get_sources()
local formatting = require("plugins.autocomplete.cmp.formatting").get_formatting()
local sorting    = require("plugins.autocomplete.cmp.sorting").get_sorting()
local window     = require("plugins.autocomplete.cmp.window").get_window()
local cmdline    = require("plugins.autocomplete.cmp.cmdline").setup_cmdline
local snippet    = require("plugins.autocomplete.cmp.snippet").get_snippet()

-- Single cmp.setup with all modules combined
cmp.setup({
  snippet    = snippet,
  mapping    = mapping,
  sources    = sources,
  formatting = formatting,
  sorting    = sorting,
  window     = window,
})

-- Setup cmdline completion
cmdline(cmp)
