-- LSP Main Configuration - NvPak 2026
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")
local on_attach = function(client, bufnr)
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr, group = group, callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr, group = group, callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Using blink.cmp for capabilities
local capabilities = require('blink.cmp').get_lsp_capabilities()

mason.setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

mason_lspconfig.setup({
    ensure_installed = { "lua_ls", "pylsp" },
    automatic_installation = true,
    handlers = {
        function (server_name)
            nvim_lsp[server_name].setup {
                on_attach = on_attach,
                capabilities = capabilities
            }
        end,
        ["lua_ls"] = function()
            nvim_lsp.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        completion = { callSnippet = "Replace" },
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false }
                    }
                },
            })
        end,
        ["pylsp"] = function()
            nvim_lsp.pylsp.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = { enabled = false },
                            mccabe = { enabled = false },
                            pyflakes = { enabled = false },
                            flake8 = { enabled = true },
                            pylint = { enabled = false },
                        }
                    }
                }
            })
        end,
    },
})
