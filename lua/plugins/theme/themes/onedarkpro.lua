-- NvPak theme-name: onedarkpro
require("onedarkpro").setup({
    filetypes = {
        all = true,
    },
    plugins = {
        -- all = false,
        -- nvim_lsp = true,
        -- polygot = false,
        -- treesitter = true
    }
})

vim.cmd("colorscheme onedark_vivid") -- onedark onelight onedark_vivid onedark_dark
