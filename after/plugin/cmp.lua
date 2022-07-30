local M = {}

local function feedkey(key, mode)
    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(key, true, true, true),
    mode, true)
end

function M:config()

    M.cmp = require('cmp')
    M.lspkind = require('lspkind')

    M.cmp.setup {
            snippet = {
            expand = function(args)
                vim.fn['UltiSnips#Anon'](args.body)
            end
        },
        sources = {
            { name = 'cmp_tabnine' },
            { name = 'ultisnips' },
            { name = 'path' },
            { name = 'buffer', keyword_length = 5},
            { name = 'calc' }
        },
        formatting = {
            format = M.lspkind.cmp_format {
                with_text = false,
                menu = {
                    cmp_tabnine = "[tabnine]",
                    ultisnips = "[snip]",
                    buffer = "[buf]",
                    path = "[path]",
                    calc = "[calc]"
                }
            }
        },
        experimental = {
            native_menu = false,
            ghost_text = true
        }
}

end


-- cmdline
require'cmp'.setup.cmdline(":", {
    sources = {{ name = "cmdline" }},
                       }
                  )

-- lsp_document_symbols
require'cmp'.setup.cmdline('/', {
    sources = require'cmp'.config.sources({{ name = 'nvim_lsp_document_symbol' }},
                                 {{ name = 'buffer' }}
                                )
                        }
                  )


