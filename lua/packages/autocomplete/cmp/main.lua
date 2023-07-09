local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
local compare = require("cmp.config.compare")
local cmp_mapping = require("packages.bindings.cmp_mappings")
local source_mapping = {
	spell = "[SPL]",
	dictionary = "[DCT]",
	nvim_lsp = "[LSP]",
	path = "[FIL]",
	luasnip = "[SNP]",
	buffer = "[BUF]",
}

local sorting = require("packages.autocomplete.cmp.sorting").setup_sorting
local snippet = require("packages.autocomplete.cmp.snippets.cmp_snippet").setup_snippet
local window = require("packages.autocomplete.cmp.window").setup_window
local sources = require("packages.autocomplete.cmp.sources").setup_sources
local mapping = require("packages.autocomplete.cmp.mapping").setup_mapping
local formatting = require("packages.autocomplete.cmp.formatting").setup_formatting
local cmdline = require("packages.autocomplete.cmp.cmdline").setup_cmdline

sorting(cmp, compare)
snippet(cmp, luasnip)
window(cmp)
sources(cmp)
mapping(cmp, cmp_mapping)
formatting(cmp, lspkind, source_mapping)
cmdline(cmp)

