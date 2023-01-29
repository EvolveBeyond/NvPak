local found_mason, mason = pcall(require, "mason")
local found_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
local found_nvim_lsp, nvim_lsp = pcall(require, "lspconfig")
local found_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
local found_lsp_file, lsp_file = pcall(require, "lsp-file-operations")
local found_null_ls, null_ls = pcall(require, "null-ls")
local found_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")

if found_mason and found_mason_lspconfig and found_nvim_lsp then
    -- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- The following example advertise capabilities to `clangd`.
    nvim_lsp.clangd.setup({
        capabilities = capabilities,
    })

    -- Lsp File Operations
    if found_lsp_file then
        lsp_file.setup({})
    end

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

    if found_null_ls and found_mason_null_ls then
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        null_ls.setup({
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
            debug = true,
            sources = {
                -- null-ls server Configure
                null_ls.builtins.diagnostics.markdownlint,
                null_ls.builtins.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.shfmt,
                null_ls.builtins.formatting.sql_formatter,
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.completion.spell,
                null_ls.builtins.formatting.xmlformat,
            },
        })

        mason_null_ls.setup({
            ensure_installed = {
                -- Write your desired package here instead of above (for people who don't like the automatic system and use space + f)
                -- for example "black"
            },
            automatic_installation = true,
            automatic_setup = false,
        })
    end

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
    if found_mason_dap then
        mason_dap.setup({
            ensure_installed = { "lua", "rust", "python" },
        })
    end

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

    nvim_lsp.efm.setup({
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        init_options = { documentFormatting = true },
        filetypes = { "python" },
        settings = {
            rootMarkers = { ".git/" },
            languages = {
                python = {
                    { formatCommand = "black --quiet -", formatStdin = true },
                },
            },
        },
    })

    nvim_lsp.format_on_save = {
        pattern = { "*.lua", "*.py", "*.go" },
    }

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
