local M = {}

function M.config()
  local lspconfig = require("lspconfig")
  local blink = require("blink.cmp")

  -- Mason setup (modern v2+ API: no deprecated ensure_installed)
  local mason = require("mason")
  mason.setup({})

  local mason_lspconfig = require("mason-lspconfig")
  -- Register servers to auto-install (modern API — no setup_handlers)
  mason_lspconfig.setup({
    ensure_installed = { "lua_ls", "pyright" },
  })

  -- Shared capabilities for blink.cmp integration
  local capabilities = blink.get_lsp_capabilities()

  -- Lua LSP with lazydev integration
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          -- Use lazydev for vim/auxiliary types
          library = vim.api.nvim_get_runtime_file("lua/", true),
        },
        telemetry = { enable = false },
      },
    },
  })

  -- Python LSP
  lspconfig.pyright.setup({ capabilities = capabilities })

  -- Add more servers here as needed
end

return M
