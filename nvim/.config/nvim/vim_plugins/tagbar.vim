if exists('g:vim_plug_installing_plugins')
  Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
  finish
endif


nmap <F8> :TagbarToggle<CR>
