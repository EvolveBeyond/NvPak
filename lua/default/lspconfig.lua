local nvim_lsp = require('lspconfig')
local lsp_installer = require('nvim-lsp-installer')


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- 1. Set up nvim-lsp-installer first!
lsp_installer.setup {}

-- 2. (optional) Override the default configuration to be applied to all servers.
-- nvim_lsp.util.default_config = vim.tbl_extend(
--   "force",
--   nvim_lsp.util.default_config,
--   {
--       on_attach = on_attach
--   }
-- )

 -- 3. Loop through all of the installed servers and set it up via lspconfig
 for _, server in ipairs(lsp_installer.get_installed_servers()) do
  nvim_lsp[server.name].setup {}
 end


lsp_installer.setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Lua long Lsp Config
nvim_lsp.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = {"vim"},
      },
    },
  },
})


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = { 'pyright', 'bashls', 'clangd', 'cssls', 'html', 'jsonls', 'pylsp', 'tsserver', 'vimls' }
-- for _, lsp in ipairs(servers) do
--    nvim_lsp[lsp].setup {
--        capabilities = capabilities,
--        on_attach = on_attach,
--    }
-- end

nvim_lsp.html.setup{
  capabilities = capabilities
}

nvim_lsp.cssls.setup{
  capabilities = capabilities
}

