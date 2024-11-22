local bind = vim.keymap.set
local set = vim.g

-- Leader bind
set.mapleader = " "

-- Buffer manager
bind("n", "<Tab>", ":bn<CR>")  -- Buffer Switch
bind("n", "<C-b>", ":confirm bd<CR>")  -- Buffer Close with confirmation

-- Auto comment
bind("v", "<C-/>", ":s/^/#/ | s/^#//<CR>")  -- Toggle comment on selection

-- Save mode
bind("n", "<C-s>", ":w<CR>")  -- Save in normal mode
bind("i", "C-s", ":w<CR>")  -- Save in insert mode
bind("c", "<C-s>", "<C-u>:w<CR>")  -- Save in command mode

-- Auto format with feedback (only if LSP is available)
bind("n", "<C-f>", function()
  if vim.lsp.buf.server_ready() then
    vim.lsp.buf.format({ async = true })
    print("Formatted successfully")  -- Feedback to the user
  else
    print("No LSP server available for formatting.")  -- Feedback if no LSP
  end
end, { silent = true })

-- Deselect search highlights
bind("n", "<leader>n", "<Cmd>noh<CR>", { silent = true })  -- Use <leader>n for clearing highlights
