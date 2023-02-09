local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Auto Sync Packer after change plugin.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
else
	packer.init({
		max_jobs = 3, -- Simultaneous download limit
		-- Move Packer use a popup window
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	})

	-- start call Packer list plugin
	return packer.startup(function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- Speed up loading Lua modules in Neovim to improve startup time.
		use("lewis6991/impatient.nvim")

		-- treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("packages.treesitter")
			end,
		})

		-- LSP Support
		use({
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"jose-elias-alvarez/null-ls.nvim",
			"jay-babu/mason-null-ls.nvim",
			"mfussenegger/nvim-dap",
			"jayp0521/mason-nvim-dap.nvim",
		})
		use("j-hui/fidget.nvim")

		-- Autocompletion
		use({
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			requires = "hrsh7th/nvim-cmp",
		})
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("saadparwaiz1/cmp_luasnip")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lua")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/cmp-nvim-lsp-signature-help")
		use("hrsh7th/cmp-nvim-lsp-document-symbol")
		use("rafamadriz/friendly-snippets")
		use({
			"L3MON4D3/LuaSnip",
			config = function()
				require("packages.snip")
			end,
		})
		use("onsails/lspkind.nvim")

		-- bracket autocompletion
		use("vim-scripts/auto-pairs-gentle")

		-- Neovim Terminal
		use({
			"s1n7ax/nvim-terminal",
			config = function()
				require("packages.NTerm")
			end,
		})
		-- Markdown Previews
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			setup = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		})
		-- Rust Code tools
		use({
			"simrat39/rust-tools.nvim",
			config = function()
				require("packages.rust-tools")
			end,
		})

		-- Debugging System
		use("nvim-lua/plenary.nvim")

		-- vim diagnostics system
		use({
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			config = function()
				require("lsp_lines").setup()
			end,
		})
		-- File Explorer
		use({
			"kyazdani42/nvim-tree.lua",
			config = function()
				require("packages.tree")
			end,
		})
		-- Fuzzy Finder
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- Dependency for better performance
		use({
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			config = function()
				require("packages.telescope")
			end,
		}) -- Fuzzy Finder
		use({
			"antosha417/nvim-lsp-file-operations",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "kyazdani42/nvim-tree.lua" },
			},
		})

		-- Dashboard
		use({
			"glepnir/dashboard-nvim",
			event = "VimEnter",
			config = function()
				require("packages.dashboard")
			end,
			requires = { "nvim-tree/nvim-web-devicons" },
		})

		-- Themes and more customize Plugins
		use({
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("packages.colorizer")
			end,
		})
		use("kyazdani42/nvim-web-devicons")
		use({ "dracula/vim", as = "dracula" }) -- Color theme
		use("cocopon/iceberg.vim") -- color theme
		use("navarasu/onedark.nvim") -- color theme
		use("shaunsingh/nord.nvim") -- color theme
		use("NvChad/base46") -- color theme
		use({ "catppuccin/nvim", as = "catppuccin" }) -- color theme
		use("tanvirtin/monokai.nvim") -- color theme

		-- StaLine Neovim StatusLine
		use({
			"tamton-aquib/staline.nvim",
			config = function()
				require("packages.staline")
			end,
		})

		-- BarBar for Tabline
		use({
			"romgrk/barbar.nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = function()
				require("packages.barbar")
			end,
		})

		-- Automatically set up your configuration after cloning packer.nvim
		-- Put this at the end after all plugins
		if packer_bootstrap then
			require("packer").sync()
		end
	end)
end
