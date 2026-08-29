-- Shadow of upstream python-lsp-server with NvPak's Python LSP plugin stack.
-- extra_packages install into the same Mason venv as python-lsp-server,
-- so python-lsp-ruff and pylsp-mypy are importable by pylsp at runtime.
return {
    name = "python-lsp-server",
    description = "Fork of the python-language-server project, maintained by the Spyder IDE team and the community.",
    homepage = "https://github.com/python-lsp/python-lsp-server",
    licenses = { "MIT" },
    languages = { "Python" },
    categories = { "LSP" },
    source = {
        id = "pkg:pypi/python-lsp-server@1.15.0?extra=all",
        extra_packages = {
            "python-lsp-ruff",
            "pylsp-mypy",
            "ruff",
            "mypy",
        },
    },
    bin = {
        pylsp = "pypi:pylsp",
    },
    neovim = {
        lspconfig = "pylsp",
    },
}
