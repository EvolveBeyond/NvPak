-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")

if telescope_setup and actions_setup then
    -- configure telescope
    telescope.setup({
        -- configure custom mappings
        defaults = {
            mappings = {
                i = {
                    ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                    ["<C-j>"] = actions.move_selection_next, -- move to next result
                    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                },
            },
        },
    })

    telescope.load_extension("fzf")
else
    return
end
