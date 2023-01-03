local found_mason ,mason = pcall(require, 'mason')
local found_mason_lspconfig ,mason_lspconfig = pcall(require, 'mason-lspconfig')
local found_nvim_lsp, nvim_lsp = pcall(require, 'lspconfig')

if found_mason and found_mason_lspconfig and found_nvim_lsp then

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

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- The following example advertise capabilities to `clangd`.
nvim_lsp.clangd.setup {
  capabilities = capabilities,
}


mason.setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- auto install LSP List
mason_lspconfig.setup {
  ensure_installed = { "sumneko_lua", "rust_analyzer", "pylsp"}
}


-- Lua long Lsp Config
nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = {"vim"},
      },
    },
  },
}


nvim_lsp.html.setup{
  capabilities = capabilities
}

nvim_lsp.cssls.setup{
  capabilities = capabilities
}

-- pyls normal python lsp
nvim_lsp.pylsp.setup{
settings = {
  pylsp = {
    plugins = {
      pycodestyle = {
        ignore = {'W391'},
        maxLineLength = 100
      }
     }
    }
   }
 }
-- rust_analyzer Config 
nvim_lsp.rust_analyzer.setup{
        cmd = {'rust_analyzer'},
        filetypes = {'rust'},
    }

-- pyre Static Python LSP
nvim_lsp.pyre.setup{
 cmd = { "pyre", "persistent" },
 filetypes = { "python" },
}

end


vim.lsp.set_log_level('debug')
