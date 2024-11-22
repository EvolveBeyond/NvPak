local treesitte = require("nvim-treesitter.configs")

-- Default languages for installation
local default_languages = { "python", "bash", "dart", "rust", "lua" }
local user_languages = vim.g.user_extra_treesitter_languages or {}

treesitte.setup({
  ensure_installed = vim.tbl_extend("force", default_languages, user_languages),
  sync_install = true, -- Install languages synchronously

	highlight = {
    enable = true, -- Enable syntax highlighting
    additional_vim_regex_highlighting = false, -- Avoid duplicate highlights
  },

	indent = {
    enable = true, -- Enable indentation
    disable = { "python" }, -- Disable for Python due to conflicts
  },

  incremental_selection = {
		enable = true,
    keymaps = {
      init_selection = "gnn", -- Initialize selection
      node_incremental = "grn", -- Increment to next node
      node_decremental = "grm", -- Decrement to previous node
      scope_incremental = "grc", -- Increment scope
    },
  },

  rainbow = {
    enable = true, -- Enable rainbow parentheses
    extended_mode = true, -- Highlight non-bracket delimiters
    max_file_lines = 1000, -- Disable for large files
  },

  context_commentstring = {
    enable = true, -- Enable context-aware commenting
    enable_autocmd = false, -- Use only with explicit configuration
	},
})
