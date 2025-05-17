return {
  -- command and filetypes
  cmd       = { "pylsp" },
  filetypes = { "python" },
  root_dir  = require("lspconfig.util").root_pattern(".git", "venv", ".env", "main.py"),

  -- settings for pylsp plugins
  settings = {
    pylsp = {
      plugins = {
        pylsp_mypy    = { enabled = true },
        pylsp_black   = { enabled = true },
        pylsp_isort   = { enabled = true },
        autopep8      = { enabled = false },
        yapf          = { enabled = false },
        pycodestyle   = { enabled = false },
      },
    },
  },

  -- you can also override on_attach or capabilities here if needed
  -- on_attach = function(client, bufnr) ... end,
  -- capabilities = some_other_capabilities,
}

