local found_treesitte, treesitte = pcall(require, "nvim-treesitter.configs")

if found_treesitte then
	treesitte.setup({
		ensure_installed = {
			"python",
			"kotlin",
			"bash",
			"dart",
			"c",
			"cpp",
			"rust",
			"lua",
		},
		-- Install languages synchronously (only applied to `ensure_installed`)
		sync_install = true,
		-- List of parsers to ignore installing
		-- ignore_install = { "haskell" },
		highlight = {
			-- `false` will disable the whole extension
			enable = true,
			-- list of language that will be disabled
			-- disable = { "" },
			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = true,
		},
		indent = {
			-- dont enable this, messes up python indentation
			enable = true,
			disable = {},
		},
	})
else
	return
end
