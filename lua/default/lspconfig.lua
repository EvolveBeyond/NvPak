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
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
       vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)
    end

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
        sources = {
            -- all sources go here.
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.completion.spell,
        },
    })

    mason_null_ls.setup({
        ensure_installed = { "stylua", "eslint", "spell" },
        automatic_installation = true,
        automatic_setup = false,
    })

    -- Never request typescript-language-server for formatting
    

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
