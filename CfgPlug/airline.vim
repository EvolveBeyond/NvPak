let g:airline_theme = 'codedark'
let g:airline#extensions#tabline#enabled = 1

" TAB in general mode will move to text buffer
nnoremap <silent> <TAB> :bnext<CR>
" SHIFT-TAB will go back
nnoremap <silent> <S-TAB> :bprevious<CR>
