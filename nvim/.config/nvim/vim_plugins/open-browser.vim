if exists('g:vim_plug_installing_plugins')
  Plug 'tyru/open-browser.vim'
  finish
endif

let g:openbrowser_default_search = 'duckduckgo'

nmap <leader>o <Plug>(openbrowser-open)
vmap <leader>o <Plug>(openbrowser-open)

nmap <leader>s <Plug>(openbrowser-smart-search)
vmap <leader>s <Plug>(openbrowser-smart-search)
