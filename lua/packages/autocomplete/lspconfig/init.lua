return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNew" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        {
            "joechrisellis/lsp-format-modifications.nvim",
            --  config = function()
            --      require("packages.autocomplete.lspconfig.lsp_format.config")
            --  end,
        },

        {
            "folke/neodev.nvim",
            config = function()
                require("packages.autocomplete.lspconfig.external_servers.neodev")
            end,
        },
    },
    config = function()
        require("packages.autocomplete.lspconfig.main")
    end,
}
