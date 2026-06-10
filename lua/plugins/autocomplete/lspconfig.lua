local M = {}

function M.config()
  local lspconfig = require("lspconfig")
  local blink = require("blink.cmp")
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  mason.setup()
  mason_lspconfig.setup({
    ensure_installed = { "lua_ls", "pyright" },
    automatic_installation = true,
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      local capabilities = blink.get_lsp_capabilities()
      lspconfig[server_name].setup({ capabilities = capabilities })
    end,
  })
end

return M
