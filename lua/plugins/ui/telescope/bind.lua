local function safe_require(module, default)
  local ok, result = pcall(require, module)
  return ok and result or default
end

-- Import plugins safely
local open_with_trouble = safe_require("trouble.sources.telescope", {}).open
local actions = safe_require("telescope.actions", {})

-- Helper for mapping
local function map(mode, keys, command, opts)
  opts = opts or { silent = true, noremap = true }
  vim.keymap.set(mode, keys, command, opts)
end

-- Telescope general mappings
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- Find files
map("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- Live grep
map("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- Grep string
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- List buffers
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- Help tags

-- Telescope git mappings
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- Git commits
map("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- Git file commits
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- Git branches
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- Git status

-- Custom Telescope bindings
local binds = {
  mappings = {
    i = {
      ["<C-t>"] = open_with_trouble,
      ["<C-k>"] = actions.move_selection_previous, -- Move to previous result
      ["<C-j>"] = actions.move_selection_next, -- Move to next result
      ["<C-q>"] = function(prompt_bufnr)
        actions.send_selected_to_qflist(prompt_bufnr)
        actions.open_qflist(prompt_bufnr)
      end,
    },
    n = { ["<C-t>"] = open_with_trouble },
  },
}

return binds
