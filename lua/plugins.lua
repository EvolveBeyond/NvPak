-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
   -- Packer can manage itself
   use 'wbthomason/packer.nvim'
  
   -- treesitter -- 
   use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
   
   -- Collection of configurations for the built-in LSP client
   use {
	   'VonHeikemen/lsp-zero.nvim',
	   requires = {
    -- LSP Support
           {'neovim/nvim-lspconfig'},
	   {'williamboman/nvim-lsp-installer'},

    -- Autocompletion
           {'hrsh7th/nvim-cmp'},
	   {'hrsh7th/cmp-buffer'},
	   {'hrsh7th/cmp-path'},
	   {'saadparwaiz1/cmp_luasnip'},
	   {'hrsh7th/cmp-nvim-lsp'},
	   {'hrsh7th/cmp-nvim-lua'},

    -- Snippets
           {'L3MON4D3/LuaSnip'},
           {'rafamadriz/friendly-snippets'},
      }
   }
    -- TabNine
    use {'tzachar/cmp-tabnine', 
    run='./install.sh', 
    requires = 'hrsh7th/nvim-cmp'}

   -- Themes and more customize Plugins
   use {'dracula/vim', as = 'dracula'}

end)
