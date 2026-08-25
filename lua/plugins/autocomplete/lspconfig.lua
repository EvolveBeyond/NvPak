local M = {}

function M.config()
  local lspconfig = require("lspconfig")
  local blink = require("blink.cmp")

  -- Mason is automatically available via rocks.nvim
  -- Configure LSP servers directly (modern approach with lazydev.nvim)
  local capabilities = blink.get_lsp_capabilities()

  -- Lua LSP with lazydev integration
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  })

  -- Python LSP
  lspconfig.pyright.setup({ capabilities = capabilities })

  -- Add more servers here as needed
end

return M
