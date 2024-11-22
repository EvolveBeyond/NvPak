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
    "pylsp"
  },

  automatic_installation = true,

  handlers = {
    ["lua_ls"] = function()
      nvim_lsp.lua_ls.setup({
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
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

    ["pylsp"] = {
      ensure_installed = {
        "pylsp_mypy",
        "pylsp_black",
        "pylsp_isort",
      },
    },
    ["pylsp"] = function()
      nvim_lsp.pylsp.setup({
        cmd = { "pylsp" },
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
