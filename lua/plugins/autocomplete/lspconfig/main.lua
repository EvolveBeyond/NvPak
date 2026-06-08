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
        "pyright"
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

        ["pyright"] = function()
            nvim_lsp.pyright.setup({
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
