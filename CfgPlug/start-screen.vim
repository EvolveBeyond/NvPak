let g:startify_custom_header = [
\ '   _   _       ____       _              _     _     ',
\ '  | \ | |_   _|  _ \ __ _| | ___ __ ___ | |__ | | __ ',
\ '  |  \| \ \ / / |_) / _` | |/ / |__/ _ \| |_ \| |/ / ',
\ '  | |\  |\ V /|  __/ (_| |   <| | | (_) | | | |   <  ',
\ '  |_| \_| \_/ |_|   \__,_|_|\_\_|  \___/|_| |_|_|\_\ ',
\ '',
\ '',
\ ]
                                      
let g:startify_session_dir = '~/.config/nvim/session'

let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']                        },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ ]


let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1

let g:webdevicons_enable_startify = 1

let g:startify_bookmarks = [
            \ { 'c': '~/.config/qtile/config.py' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.zimrc' },
            \ '~/Projects',
            \ ]

let g:startify_enable_special = 0
