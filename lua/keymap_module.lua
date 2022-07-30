local M = {}

M.map = function(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

M.vim_opt_toggle = function(opt, on, off, name)
    local message = name
    if vim.opt[opt]:get() == off then
        vim.opt[opt] = on
        message = message .. " Enabled" else
        vim.opt[opt] = off
        message = message .. " Disabled"
    end
        vim.notify(message)
end

return M
