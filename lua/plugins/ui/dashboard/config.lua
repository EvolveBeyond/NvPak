local headers = {
  {
    "███╗   ██╗██╗   ██╗██████╗  █████╗ ██╗  ██╗",
    "████╗  ██║██║   ██║██╔══██╗██╔══██╗██║ ██╔╝",
    "██╔██╗ ██║██║   ██║██████╔╝███████║█████╔╝ ",
    "██║╚██╗██║╚██╗ ██╔╝██╔═══╝ ██╔══██║██╔═██╗ ",
    "██║ ╚████║ ╚████╔╝ ██║     ██║  ██║██║  ██╗",
    "╚═╝  ╚═══╝  ╚═══╝  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝",
  },
  {
    "Neovim is not a text editor.",
    "It's a way of life.",
  },
  {
    "Welcome to Neovim!",
    "Where coding becomes an art.",
  },
}

require("dashboard").setup({
  theme = "hyper",
  config = {
    header = headers[math.random(#headers)], -- Randomly choose a header
    shortcut = {
      { desc = " Update Plugins", action = "PackerSync", key = "u", hl = "Keyword" },
      { desc = " Find Files", action = "Telescope find_files", key = "f", hl = "Function" },
      { desc = " New File", action = "enew", key = "n", hl = "Type" },
      { desc = " Quit Neovim", action = "qa", key = "q", hl = "Error" },
      { desc = " Settings", action = "edit $MYVIMRC", key = "s", hl = "Statement" },
    },
  },
})
