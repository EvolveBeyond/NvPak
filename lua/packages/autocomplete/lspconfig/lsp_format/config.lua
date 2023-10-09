local lsp_format = require("lsp-format-modifications")

local config = {
    -- The callback that is invoked to compute a diff so that we know what to
    -- format. This defaults to vim.diff with some sensible defaults.
    diff_callback = function(compareee_content, buf_content)
        return vim.diff(compareee_content, buf_content, {})
    end,

    -- The callback that is invoked to actually do the formatting on the changed
    -- hunks. Defaults to vim.lsp.buf.format (requires Neovim ≥ 0.8).
    format_callback = vim.lsp.buf.format,

    -- The VCS to use. Possible options are: "git", "hg". Defaults to "git".
    vcs = "git",

    -- EXPERIMENTAL: when true, do not attempt to format the outermost empty
    -- lines in diff hunks, and do not touch hunks consisting of entirely empty
    -- lines. For some LSP servers, this can result in more intuitive behaviour.
    experimental_empty_line_handling = false
}

lsp_format.format_modifications(client, bufnr, config)
