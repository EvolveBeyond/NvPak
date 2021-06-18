" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Git integration
Plug 'tpope/vim-fugitive'
" Auto-close braces and scopes
Plug 'jiangmiao/auto-pairs
" Unmanaged plugin (manually installed and updated)
Plug 'itchyny/vim-gitbranch'
" Comment/Uncomment tool
Plug 'scrooloose/nerdcommenter'
" Switch to the begining and the end of a block by pressing %
Plug 'tmhedberg/matchit'
" A Tree-like side bar for better navigation
Plug 'scrooloose/nerdtree'
" start screen strtify 
Plug 'mhinz/vim-startify'
" FzF Plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" themes and modeline
Plug 'tomasiser/vim-code-dark'
Plug 'ryanoasis/vim-devicons' " Use the icon plugin for better behavior
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'gosukiwi/vim-atom-dark'
Plug 'rakr/vim-one'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'kaicataldo/material.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'wadackel/vim-dogrun'
Plug 'rmolin88/pomodoro.vim'
" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" vim polyglot
Plug 'sheerun/vim-polyglot'
Plug 'https://github.com/McSinyx/vim-octave.git', {'for': 'octave'}
" coc vim 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Syntax Plugins
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
" Python 
Plug 'jmcantrell/vim-virtualenv'
" C# Plugins
 Plug 'OmniSharp/omnisharp-vim'
 " Markdown 
 Plug 'godlygeek/tabular'
 Plug 'plasticboy/vim-markdown'
 Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
 " Js And TypeScript
 Plug 'leafgarland/typescript-vim'
 Plug 'peitalin/vim-jsx-typescript'
" Initialize plugin system
call plug#end()
