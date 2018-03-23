if exists('g:vim_plug_installing_plugins')
  Plug 'neomake/neomake'
  finish
endif

autocmd! BufWritePost * Neomake

let g:neomake_list_height = 5
