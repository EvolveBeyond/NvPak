-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- Speed up loading Lua modules in Neovim to improve startup time.
  use 'lewis6991/impatient.nvim'

   -- treesitter --
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }


  use {
      'VonHeikemen/lsp-zero.nvim',
      requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/nvim-lsp-installer'},
      {'j-hui/fidget.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}, -- Tabnine Support Plugin
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      {'hrsh7th/cmp-cmdline'}, -- NeoVim Comment System Autocomple
      {'hrsh7th/cmp-nvim-lsp-signature-help'},
      {'hrsh7th/cmp-nvim-lsp-document-symbol'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }

  -- Run Rust Code and Debugging System
  use 'simrat39/rust-tools.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap'

  -- File Explorer
  use {
    'kyazdani42/nvim-tree.lua',
     tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
  -- Themes and more customize Plugins
  use 'norcalli/nvim-colorizer.lua'
  use 'kyazdani42/nvim-web-devicons'
  use {'dracula/vim', as = 'dracula'} -- Color theme
  use 'cocopon/iceberg.vim'   -- color theme
  use 'joshdick/onedark.vim'   -- color theme
  use 'shaunsingh/nord.nvim'

  -- LuaLine Neovim StatusLine
  use 'tamton-aquib/staline.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
