local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opt = {
	ui = {
		wrap = true, -- wrap the lines in the ui
		throttle = 20, -- how frequently should the ui process render events
	},
	checker = {
		-- automatically check for plugin updates
		enabled = false,
		concurrency = nil, ---@type number? set to 1 to check for updates very slowly
		notify = true, -- get a notification when new updates are found
		frequency = 3600, -- check for updates every hour
	},
	change_detection = {
		-- automatically check for config file changes and reload the ui
		enabled = false,
		notify = true, -- get a notification when changes are found
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true, -- reset the package path to improve startup time
		--  rtp = {
		--  	reset = true, -- reset the runtime path to $VIMRUNTIME and your config directory
		--  	---@type string[]
		--  	paths = {}, -- add any custom paths here that you want to includes in the rtp
		--  	---@type string[] list any plugins you want to disable here
		--  	disabled_plugins = {
		--  		-- "gzip",
		--  		-- "matchit",
		--  		-- "matchparen",
		--  		-- "netrwPlugin",
		--  		-- "tarPlugin",
		--  		-- "tohtml",
		--  		-- "tutor",
		--  		-- "zipPlugin",
		--  	},
		--  },
	},
	-- lazy can generate helptags from the headings in markdown readme files,
	-- so :help works even for plugins that don't have vim docs.
	-- when the readme opens with :help it will be correctly displayed as markdown
	readme = {
		root = vim.fn.stdpath("state") .. "/lazy/readme",
		files = { "README.md", "lua/**/README.md" },
		-- only generate markdown helptags for plugins that dont have docs
		skip_if_doc_exists = true,
	},
}

local plugins = {
	-- Speed up loading Lua modules in Neovim to improve startup time.
	{
		"lewis6991/impatient.nvim",
		lazy = false,
	},
	-- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it
	{
		"nvim-treesitter/nvim-treesitter",
		cmd = ":TSUpdate",
		config = function()
			require("packages.treesitter")
		end,
	},
	-- lsp plugins
	{
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("packages.lspconfig")
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			config = function()
				require("packages.null-ls")
			end,
		},
		{
			"j-hui/fidget.nvim",
		},
		{
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			{ "tzachar/cmp-tabnine", cmd = "./install.sh" }, -- tabnine plugin
			dependencies = "hrsh7th/nvim-cmp",
			config = function()
				require("packages.cmp")
			end,
		},
	},
}

require("lazy").setup(plugins, opt)
