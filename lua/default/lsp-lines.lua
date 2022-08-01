require("lsp_lines").setup()

vim.diagnostic.config({
  virtual_text = false, -- Disable virtual_text since it's redundant due to lsp_lines.
  virtual_lines = {
    only_current_line = true,
    spacing = 5,
    severity_limit = 'Warning',
                  }
    })
