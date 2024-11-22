local autopair = require('ultimate-autopair')

autopair.setup({
    conf = {
    profile = 'default',  -- Default profile setup
    map = true,           -- Allow general insert maps
    cmap = true,          -- Allow cmd-line maps
    pair_map = true,      -- Allow pair insert maps
    pair_cmap = true,     -- Allow pair cmd-line maps
    multiline = true,     -- Enable multiline support
    bs = {
            enable = true,
      map = '<bs>',
      cmap = '<bs>',
            overjumps = true,
      space = true,
            indent_ignore = false,
            single_delete = false,
            conf = {},
      multi = true,  -- Enable multi-config for complex pair removal
        },
    cr = {
            enable = true,
      map = '<cr>',
      autoclose = true,  -- Enable autoclosing of pairs
            conf = { cond = function(fn) return not fn.in_lisp() end },
            multi = false,
        },
    space = {
            enable = true,
      map = ' ',
      cmap = ' ',
            check_box_ft = { 'markdown', 'vimwiki', 'org' },
            conf = {},
            multi = false,
        },
    fastwarp = {
            enable = true,
            enable_normal = true,
            enable_reverse = true,
      map = '<A-e>',
      rmap = '<A-E>',
      cmap = '<A-e>',
      rcmap = '<A-E>',
            multiline = true,
            nocursormove = true,
            do_nothing_if_fail = true,
      no_filter_nodes = { 'string', 'raw_string' },
      faster = true,  -- Enable fastwarp for better performance
            conf = {},
            multi = false,
        },
    close = {
            enable = true,
      map = '<A-)>',
      cmap = '<A-)>',
            do_nothing_if_fail = true,
        },
    tabout = {
            enable = false,
      map = '<A-tab>',
      cmap = '<A-tab>',
            do_nothing_if_fail = true,
        },
    extensions = {
            cmdtype = { skip = { '/', '?', '@', '-' }, p = 100 },
            filetype = { p = 90, nft = { 'TelescopePrompt' }, tree = true },
            escape = { filter = true, p = 80 },
            tsnode = {
                p = 60,
        separate = { 'comment', 'string', 'raw_string' },
            },
            cond = { p = 40, filter = true },
            alpha = { p = 30, filter = false, all = false },
    },
    internal_pairs = {
      { '[', ']', fly = true, newline = true, space = true },
      { '(', ')', fly = true, newline = true, space = true },
      { '"', '"', suround = true, multiline = false },
      { "'", "'", suround = true, cond = function(fn) return not fn.in_lisp() end },
      { '<!--', '-->', ft = { 'html', 'markdown' }, space = true },
        },
    }
})
