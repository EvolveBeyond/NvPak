local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
  -- Enable hover preview
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Display error and warning indicators
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "LspDocumentHighlight" })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = "LspDocumentHighlight",
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      group = "LspDocumentHighlight",
      callback = vim.lsp.buf.clear_references,
    })
  end
end

-- Define capabilities with snippet and resolve support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

-- Merge in capabilities from cmp_nvim_lsp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
    "ruff",     -- Ruff for Python linting and formatting
    "pyright",  -- Pyright for Python type checking
  },
  automatic_installation = true,  -- Automatically install missing LSP servers

  handlers = {
    ["lua_ls"] = function()
      nvim_lsp.lua_ls.setup({
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            diagnostics = {
              enable = true,
              globals = { "vim" },
              underline = true,     -- underline errors/warnings in the code
              severity_sort = true, -- sort errors/warnings by severity
              signs = true,         -- add signs in the gutter for errors/warnings
            },
            workspace = { checkThirdParty = false },
          },
        },
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,

    ["ruff"] = function()
      nvim_lsp.ruff.setup({
        init_options = {
          settings = {
            logLevel = "warn",  -- Adjust logging level if needed (e.g., 'debug', 'info', 'warn', 'error')
          },
        },
        on_attach = on_attach,           -- Attach your custom on_attach function
        capabilities = capabilities,     -- Use the capabilities defined earlier
      })
    end,

    ["pyright"] = function()
      nvim_lsp.pyright.setup({
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",  -- Set type checking level (can be 'basic' or 'strict')
              ignore = { "*" },            -- Ignore all files for analysis, using Ruff for linting/diagnostics
            },
          },
          pyright = {
            disableOrganizeImports = true, -- Use Ruff's import organizer instead
          },
        },
        on_attach = on_attach,           -- Attach your custom on_attach function
        capabilities = capabilities,     -- Use the capabilities defined earlier
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
