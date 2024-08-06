return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    event = { "BufRead" },
    config = function()
        require("packages.autocomplete.nvim-treesitter.indent.main")
    end,
}
