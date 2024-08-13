local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
local compare = require("cmp.config.compare")

local source_mapping = {
    spell = "[SPL]",
    dictionary = "[DCT]",
    nvim_lsp = "[LSP]",
    path = "[FIL]",
    luasnip = "[SNP]",
    buffer = "[BUF]",
}

local sorting = require("plugins.autocomplete.cmp.sorting").setup_sorting
local snippet = require("plugins.autocomplete.cmp.snippets.cmp_snippet").setup_snippet
local window = require("plugins.autocomplete.cmp.window").setup_window
local sources = require("plugins.autocomplete.cmp.sources").setup_sources
local bindings = require("plugins.autocomplete.cmp.bindings").setup_mapping
local formatting = require("plugins.autocomplete.cmp.formatting").setup_formatting
local cmdline = require("plugins.autocomplete.cmp.cmdline").setup_cmdline

local function setup()
    sorting(cmp, compare)
    snippet(cmp, luasnip)
    window(cmp)
    sources(cmp)
    bindings(cmp)
    formatting(cmp, lspkind, source_mapping)
    cmdline(cmp)
end

setup()
