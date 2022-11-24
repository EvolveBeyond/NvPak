local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end


-- Auto Sync Packer after change plugin.lua
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
packer.startup(
  function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'


    -- treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    config = function()
      require('default.packages.treesitter')
    end
  }


        -- LSP Support
        use {
          "williamboman/mason.nvim",
          "williamboman/mason-lspconfig.nvim",
            }
          use {"neovim/nvim-lspconfig",
                after = {"mason", "mason-lspconfig"},
                config = require('default.lspconfig')
              }
        use 'j-hui/fidget.nvim'

        -- Autocompletion
        use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
        use {
	            'hrsh7th/nvim-cmp',
              after = {"cmp-tabnine"},
	            config = require('default.packages.cmp')
	          }
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'saadparwaiz1/cmp_luasnip'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-nvim-lua'
        use 'hrsh7th/cmp-cmdline'
        use 'hrsh7th/cmp-nvim-lsp-signature-help'
        use 'hrsh7th/cmp-nvim-lsp-document-symbol'
        use {
              'L3MON4D3/LuaSnip', 
              config = function() 
                          require('default.packages.snip')
                      end
                    }
        use 'onsails/lspkind.nvim'


   -- Mason LSP Installer extension
   use 'jose-elias-alvarez/null-ls.nvim'
   use {
	    "jayp0521/mason-null-ls.nvim",
	    after = {
		    "null-ls.nvim",
		    "mason.nvim",
	            },
      }

    -- bracket autocompletion
    use 'vim-scripts/auto-pairs-gentle'


    -- Neovim Terminal
    use {
    's1n7ax/nvim-terminal',
    config = function()
      require('default.packages.NTerm')
    end,
        }
    -- Markdown Previews
    use({
        "iamcco/markdown-preview.nvim",
        run = function() fn["mkdp#util#install"]() end,
        })
    -- Rust Code tools
    use {'simrat39/rust-tools.nvim', config = require('default.packages.rust-tools')}

    -- Debugging System
    use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'

    -- vim diagnostics system 
    use {
          "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
          config = function()
          require("lsp_lines").setup()
          end,
       }

    -- File Explorer
    use {'kyazdani42/nvim-tree.lua', config = require('default.packages.tree')}

    -- Themes and more customize Plugins
    use {
      'norcalli/nvim-colorizer.lua', 
      config = function ()
      require('default.packages.colorizer')
               end
    }
    use 'kyazdani42/nvim-web-devicons'
    use {'dracula/vim', as = 'dracula'} -- Color theme
    use 'cocopon/iceberg.vim'  -- color theme
    use 'navarasu/onedark.nvim' -- color theme
    use 'shaunsingh/nord.nvim' -- color theme
    use  'NvChad/base46'-- color theme

    -- StaLine Neovim StatusLine
    use { 'tamton-aquib/staline.nvim', config = require('default.packages.staline') }

    -- BarBar for Tabline
    use {
    'romgrk/barbar.nvim',
     requires = {'kyazdani42/nvim-web-devicons'},
     config = require('default.packages.barbar')
        }

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
   if packer_bootstrap then
     require('packer').sync()
   end
  end)
end
