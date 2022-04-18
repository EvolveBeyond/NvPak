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
   -- LSP Support
    use 'hrsh7th/cmp-nvim-lsp'
    use 'neovim/nvim-lspconfig'

    -- Autocompletion 
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'onsails/lspkind-nvim'
    use 'f3fora/cmp-spell'
    use 'hrsh7th/cmp-emoji'

    -- Snippets 
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'rafamadriz/friendly-snippets'
    use 'ray-x/lsp_signature.nvim'
    
    -- TabNine
    use {'tzachar/cmp-tabnine', 
    run='./install.sh', 
    requires = 'hrsh7th/nvim-cmp'}
    
   -- Themes and more customize Plugins
   use {'dracula/vim', as = 'dracula'}

end)
