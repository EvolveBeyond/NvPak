" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Unmanaged plugin (manually installed and updated)
Plug 'itchyny/vim-gitbranch'
" start screen strtify 
Plug 'mhinz/vim-startify'
" FzF Plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" themes and modeline
Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons' " Use the icon plugin for better behavior
Plug 'sheerun/vim-polyglot'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'gosukiwi/vim-atom-dark'
Plug 'rakr/vim-one'
Plug 'kaicataldo/material.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'wadackel/vim-dogrun'
Plug 'rmolin88/pomodoro.vim'
Plug 'liuchengxu/vim-which-key'
" coc vim 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tabnine', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
" Syntax Plugins
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
" Python 
 Plug 'jmcantrell/vim-virtualenv'
 Plug 'Vimjas/vim-python-pep8-indent'
 Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
 Plug 'jeetsukumaran/vim-pythonsense'
 Plug 'vim-scripts/indentpython.vim'
 Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" C# Plugins
 Plug 'OmniSharp/omnisharp-vim'
 Plug 'nickspoons/vim-sharpenup'
 " Markdown 
 Plug 'godlygeek/tabular'
 Plug 'plasticboy/vim-markdown'
 Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
 " Js And TypeScript
 Plug 'leafgarland/typescript-vim'
 Plug 'peitalin/vim-jsx-typescript'
" Initialize plugin system
call plug#end()
