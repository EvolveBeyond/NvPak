local M = {}

function M.config()
  -- Graceful degradation: check for required rocks before proceeding
  local has_lspconfig = pcall(require, "lspconfig")
  local has_mason = pcall(require, "mason")
  local has_mason_lspconfig = pcall(require, "mason-lspconfig")
  local has_blink = pcall(require, "blink.cmp")

  if not (has_lspconfig and has_mason and has_mason_lspconfig and has_blink) then
    local missing = {}
    if not has_lspconfig then table.insert(missing, "nvim-lspconfig") end
    if not has_mason then table.insert(missing, "mason.nvim") end
    if not has_mason_lspconfig then table.insert(missing, "mason-lspconfig.nvim") end
    if not has_blink then table.insert(missing, "blink.cmp") end
    vim.notify(
      "LSP unavailable — missing rocks: " .. table.concat(missing, ", ") ..
      ". Run :Rocks sync",
      vim.log.levels.WARN,
      { title = "NvPak LSP" }
    )
    return
  end

  local lspconfig = require("lspconfig")
  local blink = require("blink.cmp")
  local mason = require("mason")
  local mason_lspconfig = require("mason-lspconfig")

  mason.setup({})

  -- Configurable server list via vim.g.nvpak_lsp_servers (fallback to defaults)
  local servers = vim.g.nvpak_lsp_servers or { "lua_ls", "pyright" }
  mason_lspconfig.setup({ ensure_installed = servers })

  local capabilities = blink.get_lsp_capabilities()

  -- Lua LSP with lazydev integration
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          -- Use lazydev for vim/auxiliary types; fallback to runtime files
          library = vim.api.nvim_get_runtime_file("lua/", true) or {},
        },
        telemetry = { enable = false },
      },
    },
  })

  -- Python LSP
  if vim.tbl_contains(servers, "pyright") then
    lspconfig.pyright.setup({ capabilities = capabilities })
  end

  -- Add more servers here as needed (extensible via vim.g.nvpak_lsp_servers)
  for _, server in ipairs(servers) do
    if server ~= "lua_ls" and server ~= "pyright" then
      local ok = pcall(function() lspconfig[server].setup({ capabilities = capabilities }) end)
      if not ok then
        vim.notify("LSP server '" .. server .. "' not found in nvim-lspconfig", vim.log.levels.WARN)
      end
    end
  end
end

return M
