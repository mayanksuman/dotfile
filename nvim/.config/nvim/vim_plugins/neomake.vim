if exists('g:vim_plug_installing_plugins')
  Plug 'neomake/neomake'
  finish
endif

autocmd! BufWritePost * Neomake
" When reading a buffer (after 1s), and when writing.
call neomake#configure#automake('rn', 1000)

let g:neomake_list_height = 5
let g:neomake_text_enabled_makers = ['proselint']
