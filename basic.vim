set encoding=UTF-8
filetype plugin indent on
syntax on
colorscheme dracula           " color themes
highlight Normal ctermbg=none
highlight NonText ctermbg=none
" set termguicolors
" set background=dark          " disable transparent Background
set number                     " Show current line number
set relativenumber             " Show relative line numbers
set splitbelow
set splitright
set clipboard+=unnamedplus
set mouse=a


" http://vimdoc.sourceforge.net/htmldoc/eval.html#last-position-jump
" https://vim.fandom.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" :help last-position-jump
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
" Python Configure
au BufNewFile,BufRead *.py
    \ set expandtab       |" replace tabs with spaces
    \ set autoindent      |" copy indent when starting a new line
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4

   

