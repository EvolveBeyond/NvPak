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

local function setup_sorting()
	cmp.setup({
		sorting = {
			priority_weight = 1.0,
			comparators = {
				compare.recently_used, -- prioritizes recently used items
				compare.kind, -- prioritizes items with the same kind
				compare.offset, -- prioritizes items closer to the cursor
				compare.order, -- prioritizes items in the same received order
				compare.sort_text, -- prioritizes prefix matches within completion items
				compare.length, -- prioritizes shorter completion items
				compare.exact, -- prioritizes items starting with exactly the same prefix
				compare.score, -- prioritizes item similarity score
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
			{
				name = "nvim_lsp",
				keyword_length = 1,
				max_item_count = 11,
			},
			{
				name = "luasnip",
				keyword_length = 2,
				max_item_count = 2,
			},
			{
				name = "buffer",
				keyword_length = 3,
				option = {
					get_bufnrs = function()
						local bufs = {}
						for _, win in ipairs(vim.api.nvim_list_wins()) do
							bufs[vim.api.nvim_win_get_buf(win)] = true
						end
						return vim.tbl_keys(bufs)
					end,
				},
				max_item_count = 10,
			},
			{
				name = "path",
				keyword_length = 3,
				max_item_count = 5,
			},
			{
				name = "spell",
				keyword_length = 3,
				option = {
					keep_all_entries = false,
					enable_in_context = function()
						return true
					end,
				},
			},
			{
				name = "nvim_lsp_signature_help",
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
	setup_sources()
	setup_sorting()
	setup_snippet()
	setup_mapping()
	setup_formatting()
	setup_window()
	setup_cmdline()
end

setup()
