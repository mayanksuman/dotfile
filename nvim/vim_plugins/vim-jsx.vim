if exists('g:vim_plug_installing_plugins')
  Plug 'mxw/vim-jsx', { 'for': ['jsx', 'javascript'] } 
  finish
endif

autocmd FileType javascript let g:jsx_ext_required = findfile('.jsx', '.;') != '' ? 0 : 1
