-- Import dependencies
local mason       = require("mason")
local mason_lsp   = require("mason-lspconfig")
local lspconfig   = require("lspconfig")

-- Utility: get server config directory
local function get_servers_path()
  return vim.fn.stdpath("config") .. "/lua/plugins/autocomplete/lspconfig/servers"
end

-- Common on_attach for all LSP servers
local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "LspDocumentHighlight" })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group  = "LspDocumentHighlight",
      callback = vim.lsp.buf.document_highlight,
    })
  end
end

-- Build capabilities merged with nvim-cmp
local function make_capabilities()
  local caps = vim.lsp.protocol.make_client_capabilities()
  caps.textDocument.completion.completionItem.snippetSupport = true
  caps.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" }
  }
  return require("cmp_nvim_lsp").default_capabilities(caps)
end

-- Initialize Mason and ensure installation
local function init_mason(servers)
  mason.setup({ ui = { icons = { server_installed = "✓", server_pending = "➜", server_uninstalled = "✗" } } })
  mason_lsp.setup({ ensure_installed = servers, automatic_installation = true })
end

-- Load server configs from `servers/` folder
local function load_server_configs(on_attach, capabilities)
  local handlers = { function(server)
    lspconfig[server].setup({ on_attach = on_attach, capabilities = capabilities })
  end }

  local dir = get_servers_path()
  for _, file in ipairs(vim.fn.readdir(dir)) do
    local name = file:match('^(.*)%.lua$')
    if name then
      local opts = require("plugins.autocomplete.lspconfig.servers." .. name)
      handlers[name] = function()
        local cfg = vim.tbl_deep_extend("force", { on_attach = on_attach, capabilities = capabilities }, opts)
        lspconfig[name].setup(cfg)
      end
    end
  end

  mason_lsp.setup_handlers(handlers)
end

-- Auto-create config file stub after Mason install
local function init_autogen()
  vim.api.nvim_create_autocmd("User", {
    pattern = "MasonInstallEnd",
    callback = function(event)
      local pkg = event.data[1]
      local path = get_servers_path() .. "/" .. pkg .. ".lua"
      if lspconfig[pkg] and vim.fn.filereadable(path) == 0 then
        vim.fn.writefile({ "return {}" }, path)
        vim.notify("Created LSP config: " .. path)
      end
    end,
  })
end

-- Command to edit a server config
local function init_edit_command(handlers)
  vim.api.nvim_create_user_command("LspEdit", function(opts)
    local name = opts.args
    local path = get_servers_path() .. "/" .. name .. ".lua"
    if vim.fn.filereadable(path) == 0 then
      vim.fn.writefile({ "return {}" }, path)
      vim.notify("Stub created: " .. path)
    end
    vim.cmd("edit " .. path)
  end, { nargs = 1, complete = function(_, line)
    return vim.tbl_filter(function(k) return k:match("^" .. line) end, vim.tbl_keys(handlers))
  end })
end

-- Main setup
local function setup()
  local servers = { "lua_ls", "pylsp", "html", "cssls" }
  local caps = make_capabilities()

  init_mason(servers)
  load_server_configs(on_attach, caps)
  init_autogen()
  init_edit_command(lspconfig)
end

-- Execute setup
setup()

return { setup = setup }
