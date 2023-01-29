local found_mason, mason = pcall(require, "mason")
local found_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
local found_nvim_lsp, nvim_lsp = pcall(require, "lspconfig")
local found_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
local found_lsp_file, lsp_file = pcall(require, "lsp-file-operations")
local found_null_ls, null_ls = pcall(require, "null-ls")
local found_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")

if found_mason
    and found_mason_lspconfig
    and found_nvim_lsp
    and found_mason_dap
    and found_lsp_file
    and found_null_ls
    and found_mason_null_ls
then
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- The following example advertise capabilities to `clangd`.
    nvim_lsp.clangd.setup({
        capabilities = capabilities,
    })

    -- Lsp File Operations
    lsp_file.setup({})

    mason.setup({
        ui = {
            icons = {
                server_installed = "✓",
                server_pending = "➜",
                server_uninstalled = "✗",
            },
        },
    })

    -- null ls config
    null_ls.setup({
        sources = {},
    })

    mason_null_ls.setup({
        ensure_installed = { "stylua", "eslint", "spell", "mypy", "block" },
        automatic_installation = true,
        automatic_setup = true,
    })
    mason_null_ls.setup_handlers()

    vim.lsp.buf.format({ timeout_ms = 2000 })

    -- auto install LSP List
    mason_lspconfig.setup({
        ensure_installed = {
            "sumneko_lua", -- lua language server
            "rust_analyzer", -- rust language server
            "pylsp", -- python language server
            "pyre", -- python language server
        },
    })

    -- auto install debugers
    mason_dap.setup({
        ensure_installed = { "lua", "rust", "python" },
    })

    -- Lua long Lsp Config
    nvim_lsp.sumneko_lua.setup({
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        },
    })

    nvim_lsp.html.setup({
        capabilities = capabilities,
    })

    nvim_lsp.cssls.setup({
        capabilities = capabilities,
    })

    -- pyls normal python lsp
    nvim_lsp.pylsp.setup({
        on_attach = on_attach,
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = {
                        ignore = { "W391" },
                        maxLineLength = 100,
                    },
                },
            },
        },
    })

    -- python static lsp
    nvim_lsp.pyre.setup({
        cmd = { "pyre", "persistent" },
        filetypes = { "python" },
    })

    -- rust_analyzer Config
    nvim_lsp.rust_analyzer.setup({
        cmd = { "rust_analyzer" },
        filetypes = { "rust" },
        root_dir = nvim_lsp.util.root_pattern("Cargo.toml", "rust-project.json"),
    })

    -- dart lsp config
    -- nvim_lsp.dart.setup {}
    -- Or if you have Dartls installed
    -- nvim_lsp.dartls.setup{
    --       cmd = {"dart", "language-server", "--protocol=lsp"},
    --       filetypes = {"dart"},
    --       init_options = {
    --                       closingLabels = true,
    --                       flutterOutline = true,
    --                       onlyAnalyzeProjectsWithOpenFiles = true,
    --                       outline = true,
    --                       suggestFromUnimportedLibraries = true
    --                     },
    --       root_dir = nvim_lsp.util.root_pattern("pubspec.yaml"),
    --       settings = {
    --               dart = {
    --                       completeFunctionCalls = true,
    --                       showTodos = true
    --                      }
    --                  }
    --               }
    --
end

vim.lsp.set_log_level("debug")
