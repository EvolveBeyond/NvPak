-- Required modules
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
local compare = require("cmp.config.compare")


-- Import setup functions from separate modules
local sorting = require("plugins.autocomplete.cmp.sorting").setup_sorting
local snippet = require("plugins.autocomplete.cmp.snippets.cmp_snippet").setup_snippet
local window = require("plugins.autocomplete.cmp.window").setup_window
local sources = require("plugins.autocomplete.cmp.sources").setup_sources
local bindings = require("plugins.autocomplete.cmp.bindings").setup_mapping
local formatting = require("plugins.autocomplete.cmp.formatting").setup_formatting
local cmdline = require("plugins.autocomplete.cmp.cmdline").setup_cmdline

-- Main setup function
local function setup()
    sorting(cmp, compare)
    snippet(cmp, luasnip)
    window(cmp)
    sources(cmp)
    bindings(cmp)
    formatting(cmp, lspkind)
    cmdline(cmp)
end


-- Run setup
setup()
