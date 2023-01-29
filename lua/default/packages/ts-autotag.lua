require("nvim-treesitter.configs").setup({
    autotag = {
        enable = true,
    },
})

-- Lsp insert updater
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = true,
})

require("nvim-ts-autotag").setup({
    filetypes = { "html", "xml" },
})
