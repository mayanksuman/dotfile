if exists('g:vim_plug_installing_plugins')
  Plug 'dsawardekar/portkey'
  finish
endif

let g:portkey_autostart = 1
nnoremap <LocalLeader>A :Alternate<CR>
