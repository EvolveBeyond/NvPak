local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
local compare = require("cmp.config.compare")
local cmp_mapping = require("packages.bindings.cmp_mappings")

local source_mapping = {
	spell = "[SPL]",
	nvim_lsp = "[LSP]",
	path = "[Path]",
	luasnip = "[Snp]",
	nvim_lua = "[Lua]",
}

local function setup_sorting()
	cmp.setup({
		sorting = {
			priority_weight = 2,
			comparators = {
				compare.offset,
				compare.recently_used,
				compare.exact,
				compare.kind,
				compare.length,
				compare.order,
				compare.sort_text,
                compare.score,

			},
			debug = {
				priority = true,
			},
		},
	})
end

local function setup_snippet()
	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
	})
end

local function setup_window()
	cmp.setup({
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
	})
end

local function setup_sources()
	cmp.setup({
		sources = {
			{ name = "nvim_lsp", priority = 2 },
			{ name = "luasnip", priority = 1 },
			{ name = "path", priority = 0 },
			{
				name = "nvim_lsp_signature_help",
				priority = 0,
			},
			{
				name = "spell",
				option = {
					keep_all_entries = false,
					enable_in_context = function()
						return true
					end,
				},
				priority = 0,
			},
		},
	})
end

local function setup_mapping()
	cmp.setup({
		mapping = cmp_mapping,
	})
end

local function setup_formatting()
	cmp.setup({
		formatting = {
			fields = {
				cmp.ItemField.Abbr,
				cmp.ItemField.Kind,
				cmp.ItemField.Menu,
			},
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 40,
				before = function(entry, vim_item)
					vim_item.kind = lspkind.presets.default[vim_item.kind]
					local menu = source_mapping[entry.source.name]

					vim_item.menu = menu

					return vim_item
				end,
			}),
		},
	})
end

local function setup_cmdline()
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "nvim_lsp_document_symbol" },
		}, {
			{ name = "buffer" },
		}),
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

local function setup()
	setup_sorting()
	setup_snippet()
	setup_window()
	setup_sources()
	setup_mapping()
	setup_formatting()
	setup_cmdline()
end

setup()
