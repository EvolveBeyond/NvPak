" config Fils
lua require('cfg.basic')

" Packer 
lua require('plugins')

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" Treesitter
lua require('cfg.treesitter')

" lsp config
lua require('cfg.lsp')


" Folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
