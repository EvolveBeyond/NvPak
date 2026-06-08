return {
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },
      diagnostics = {
        enable        = true,
        globals       = { "vim" },
        underline     = true,
        severity_sort = true,
        signs         = true,
      },
      workspace = { checkThirdParty = false },
    },
  },
}

