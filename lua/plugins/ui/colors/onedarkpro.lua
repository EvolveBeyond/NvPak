require("onedarkpro").setup({
  filetypes = {
    all = true,
  },
  plugins = {
    all = false,
    nvim_lsp = true,
    polygot = false,
    treesitter = true
  }
})

-- somewhere in your config:
vim.cmd("colorscheme onedark") -- onedark onelight onedark_vivid onedark_dark

