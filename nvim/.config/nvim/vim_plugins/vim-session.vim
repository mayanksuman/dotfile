if exists('g:vim_plug_installing_plugins')
  Plug 'xolox/vim-session'
  Plug 'tpope/vim-obsession'
  finish
endif

let g:session_autosave = 0
let g:session_autoload = 0
nnoremap <leader>os :OpenSession<CR>
let g:session_directory=g:runtime_data_location. 'session'
