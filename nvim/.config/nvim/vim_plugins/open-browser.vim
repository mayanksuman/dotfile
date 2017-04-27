if exists('g:vim_plug_installing_plugins')
  Plug 'tyru/open-browser.vim'
  finish
endif

nmap <leader>o <Plug>(openbrowser-smart-search)
vmap <leader>o <Plug>(openbrowser-smart-search)
