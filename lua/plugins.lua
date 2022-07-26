-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


-- Auto Sync Packer after chnage plugin.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

vim.cmd [[packadd packer.nvim]]

-- Use a protected call so we don`t error out on first use
 local status_ok, packer = pcall(require, "packer")
 if not status_ok then
  return
 end

-- Move Packer use a popup window
packer.init {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- start call Packer list plugin
local startup = require("packer").startup

startup(
  function(use, use_rocks)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Speed up loading Lua modules in Neovim to improve startup time.
    use 'lewis6991/impatient.nvim'


    -- telescope File Search
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} }
        }

    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}



    use {'VonHeikemen/lsp-zero.nvim', -- Lsp and Autocompletion System Manager
        requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},
        {'williamboman/nvim-lsp-installer'},
        {'j-hui/fidget.nvim'},

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        -- {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}, -- Tabnine Support Plugin
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

    -- Markdown Previews
    use({
        "iamcco/markdown-preview.nvim",
        run = function() fn["mkdp#util#install"]() end,
        })
    -- Rust Code tools
    use 'simrat39/rust-tools.nvim'

    -- Debugging System
    use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'

    -- Toggle Terminal
    use {"akinsho/toggleterm.nvim", tag = 'v1.*', config = function()
        require("toggleterm").setup()
      end}

    -- File Explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Themes and more customize Plugins
    use 'norcalli/nvim-colorizer.lua'
    use 'kyazdani42/nvim-web-devicons'
    use {'dracula/vim', as = 'dracula'} -- Color theme
    use 'cocopon/iceberg.vim'  -- color theme
    use 'joshdick/onedark.vim' -- color theme
    use 'shaunsingh/nord.nvim' -- color theme

    -- StaLine Neovim StatusLine
    use 'tamton-aquib/staline.nvim'

    -- BarBar for Tabline
    use {
    'romgrk/barbar.nvim',
     requires = {'kyazdani42/nvim-web-devicons'}
        }
   if packer_bootstrap then
     require('packer').install()
   end
  end
)

