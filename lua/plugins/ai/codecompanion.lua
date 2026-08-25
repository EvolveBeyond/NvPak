local M = {}

function M.config()
  local codecompanion = require("codecompanion")

  codecompanion.setup({
    adapters = {
      omniroute = function()
        return require("codecompanion.adapters").from_env({
          -- Uses Omniroute at localhost:20128 as primary provider
          url = "http://localhost:20128/v1/chat/completions",
          env = {
            api_key = "OMNIROUTE_KEY",
          },
          model = "fastdocs",
        })
      end,
    },
    strategies = {
      chat = { adapter = "omniroute" },
      inline = { adapter = "omniroute" },
      cmd = { adapter = "omniroute" },
    },
  })

  -- Keybindings for AI features
  local map = vim.keymap.set
  map({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionAction<cr>", { desc = "AI: Action" })
  map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI: Chat" })
  map("v", "<leader>ae", "<cmd>CodeCompanionEmath<cr>", { desc = "AI: Explain selection" })
end

return M
