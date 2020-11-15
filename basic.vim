set encoding=UTF-8
syntax enable
let g:codedark_conservative = 1
colorscheme codedark              " color themes
set termguicolors
set background=dark
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set splitbelow
set splitright
set clipboard+=unnamedplus
set mouse=a

autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

set completeopt-=preview

set colorcolumn=92

" HTML & CSS Configure
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4


