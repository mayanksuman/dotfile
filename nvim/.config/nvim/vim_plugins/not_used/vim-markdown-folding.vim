if exists('g:vim_plug_installing_plugins')
  Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' } 
  finish
endif

let g:markdown_fold_override_foldtext=0
