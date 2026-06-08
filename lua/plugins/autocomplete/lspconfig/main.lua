local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
  -- Enable hover preview
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Display error and warning indicators
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = group,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      group = group,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Define capabilities with snippet and resolve support
-- Merge in capabilities from blink.cmp
local capabilities = require('blink.cmp').get_lsp_capabilities()

mason.setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        },
    },
})

-- Setup LSP configurations after installation
mason_lspconfig.setup({

    ensure_installed = {
        "lua_ls",
        "pylsp"
    },

    automatic_installation = true,

    handlers = {
        -- Default handler for servers without specific configurations
        function (server_name)
            nvim_lsp[server_name].setup {
                on_attach = on_attach,
                capabilities = capabilities,
            }
        end,

        ["lua_ls"] = function()
            nvim_lsp.lua_ls.setup({
                settings = {
                    Lua = {
                        completion = {
                            callSnippet = "Replace", -- "Disable" | "Replace"
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false, -- Avoids warnings for vim non-standard libraries
                        },
                        telemetry = { enable = false }, -- Opt-out of telemetry
                    },
                },
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,

        -- Note: Installation of pylsp extensions like pylsp_mypy, pylsp_black, pylsp_isort
        -- should be handled by the user's Python environment (e.g., pip install ...).
        -- Mason ensures 'pylsp' server itself is installed if listed in the outer 'ensure_installed'.
        ["pylsp"] = function()
            nvim_lsp.pylsp.setup({
                cmd = { "pylsp" }, -- Ensure pylsp is in PATH
                filetypes = { "python" },
                root_dir = nvim_lsp.util.root_pattern(".git", "venv", ".env", "main.py"),
                settings = {
                    pylsp = {
                        plugins = {
                            pylsp_mypy = { enabled = true },
                            pylsp_black = { enabled = true },
                            pylsp_isort = { enabled = true },
                            -- disabled standard plugins
                            autopep8 = { enabled = false }, -- covered by black
                            yapf = { enabled = false },     -- covered by black
                            pycodestyle = { enabled = false },
                            pydocstyle = { enabled = false },
                        },
                    },
                },
                single_file_support = true,
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
        ["html"] = function()
            nvim_lsp.html.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
        ["cssls"] = function()
            nvim_lsp.cssls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end,
    },
})

-- Set logging level for LSP messages
-- vim.lsp.set_log_level("debug") -- Uncomment this line for debugging
