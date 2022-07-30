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
else

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


    use {
  	"ahmedkhalf/lsp-rooter.nvim",
  	config = function()
    		  require("lsp-rooter").setup {
     	 	  -- your configuration comes here
      	 	  -- or leave it empty to use the default settings
      	 	  -- refer to the configuration section below
    				              }
  		 end
	}

    
        -- LSP Support
        use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
        use 'williamboman/nvim-lsp-installer'
        use 'j-hui/fidget.nvim'

        -- Autocompletion
        use 'hrsh7th/nvim-cmp'
        use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'saadparwaiz1/cmp_luasnip'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-nvim-lua'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/cmp-nvim-lsp-signature-help'
        use 'hrsh7th/cmp-nvim-lsp-document-symbol'
        use 'onsails/diaglist.nvim'
        use 'L3MON4D3/LuaSnip'
        use 'onsails/lspkind.nvim'
      
    
   -- Snippets
   use {
    'hrsh7th/cmp-vsnip', requires = {
      'hrsh7th/vim-vsnip',
      'rafamadriz/friendly-snippets',
                                    }
       }

    -- bracket autocompletion
    use 'vim-scripts/auto-pairs-gentle'
    use 'windwp/nvim-ts-autotag'


    -- Neovim Terminal
    use {
    's1n7ax/nvim-terminal',
    config = function()
        vim.o.hidden = true
        require('nvim-terminal').setup()
    end,
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
    use {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
          config = function()
            require("lsp_lines").setup()
          end,
      }
    -- File Explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Themes and more customize Plugins
    use 'norcalli/nvim-colorizer.lua'
    use 'kyazdani42/nvim-web-devicons'
    use {'dracula/vim', as = 'dracula'} -- Color theme
    use 'cocopon/iceberg.vim'  -- color theme
    use 'joshdick/onedark.vim' -- color theme
    use 'shaunsingh/nord.nvim' -- color theme
    use  'NvChad/base46'-- color theme

    -- StaLine Neovim StatusLine
    use 'tamton-aquib/staline.nvim'

    -- BarBar for Tabline
    use {
    'romgrk/barbar.nvim',
     requires = {'kyazdani42/nvim-web-devicons'}
        }
   if packer_bootstrap then
     require('packer').sync()
   end
  end
)
end
