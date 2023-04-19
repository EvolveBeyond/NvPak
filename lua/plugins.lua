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
	defaults = {
		lazy = false, -- should plugins be lazy-loaded?
		version = nil,
		-- version = "*", -- enable this to try installing the latest stable versions of plugins
	},
	-- leave nil when passing the spec as the first argument to setup()
	spec = nil, -- @type LazySpec
	lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
	concurrency = 2, -- @type number limit the maximum amount of concurrent tasks
	git = {
		-- defaults for the `Lazy log` command
		-- log = { "-10" }, -- show the last 10 commits
		log = { "--since=3 days ago" }, -- show commits from the last 3 days
		timeout = 120, -- kill processes that take more than 2 minutes
		url_format = "https://github.com/%s.git",
		-- lazy.nvim dependencies git >=2.19.0. If you really want to use lazy with an older version,
		-- then set the below to false. This is should work, but is NOT supported and will
		-- increase downloads a lot.
		filter = true,
	},
	-- dev = {
	-- directory where you store your local plugin projects
	-- path = "~/projects",
	-- @type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
	-- patterns = {}, -- For example {"folke"}
	-- fallback = false, -- Fallback to git when local plugin doesn't exist
	-- },
	install = {
		-- install missing plugins on startup. This doesn't increase startup time.
		missing = true,
		-- try to load one of these colorschemes when starting an installation during startup
		colorscheme = { "habamax" },
	},
	ui = {
		wrap = true, -- wrap the lines in the ui
		throttle = 20, -- how frequently should the ui process render events
	},
	checker = {
		-- automatically check for plugin updates
		enabled = true,
		concurrency = 4, -- @type number? set to 1 to check for updates very slowly
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

	-- notification plugin
	{
		"rcarriga/nvim-notify",
		config = function()
			require("packages.notify")
		end,
	},

	{
		"mrded/nvim-lsp-notify",
		dependencies = { "rcarriga/nvim-notify" },
		config = true, -- function()
		-- require("packages.lsp_notify")
		-- end,
	},
	-- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter in Neovim and to provide some basic functionality such as highlighting based on it
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufReadPre",
		build = ":TSUpdate",
		config = function()
			require("packages.treesitter")
		end,
	},
	-- lsp plugins
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNew" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("packages.lspconfig")
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNew" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = function()
			require("packages.null-ls")
		end,
	},
	-- autocompeletion plugins
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind.nvim",
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"f3fora/cmp-spell",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = function()
			require("packages.cmp")
			require("packages.snip")
		end,
	},
	-- bracket autocompletion
	{
		"m4xshen/autoclose.nvim",
		event = { "BufReadPre" },
		config = function()
			require("packages.autoclose")
		end,
	},
	-- Debugging System
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mfussenegger/nvim-dap",
		},
		config = function()
			require("packages.dap")
		end,
		ft = { "python", "rust", "lua" },
	},
	{
		"folke/neodev.nvim",
		config = function()
			require("packages.neodev")
		end,
	},
	-- vim diagnostics system
	{
		url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		event = { "BufRead" },
		config = function()
			require("packages.lsp_lines")
		end,
	},
	{
		"folke/trouble.nvim",
		event = { "BufRead" },
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("packages.trouble")
		end,
	},
	-- Fuzzy Finder

	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		event = { "VimEnter", "BufRead" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("packages.telescope")
		end,
	},
	-- Tree File Explorer
	{
		"kyazdani42/nvim-tree.lua",
		event = { "VimEnter", "BufEnter" },
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("packages.tree")
		end,
	},
	-- Neovim Project Manager
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("packages.project")
		end,
	},
	-- Neovim Terminal
	{
		"s1n7ax/nvim-terminal",
		event = { "BufRead" },
		config = function()
			require("packages.NTerm")
		end,
	},
	-- Markdown Previews
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
		ft = "markdown",
	},
	-- Themes and more customize Plugins
	-- Dashboard
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("packages.dashboard")
		end,
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	-- barabr TabLine
	{
		"romgrk/barbar.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("packages.barbar")
		end,
	},
	-- lua Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPre" },
		config = function()
			require("packages.ui.lualine.main")
		end,
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	-- This plugin adds indentation guides to all lines (including empty lines).
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufRead" },
		config = function()
			require("packages.indent")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPre" },
		config = function()
			require("packages.colorizer")
		end,
	},
	-- themes
	{
		"Mofiqul/dracula.nvim",
		{ "catppuccin/nvim", name = "catppuccin" },
		"cocopon/iceberg.vim",
		"navarasu/onedark.nvim",
		"shaunsingh/nord.nvim",
		"jayden-chan/base46.nvim",
		"tanvirtin/monokai.nvim",
		{ "rose-pine/neovim", name = "rose-pine" },
	},
}

require("lazy").setup(plugins, opt)
