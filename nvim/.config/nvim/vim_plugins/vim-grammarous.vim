if exists('g:vim_plug_installing_plugins')
  Plug 'rhysd/vim-grammarous'
  finish
endif

let g:grammarous#default_comments_only_filetypes = {
            \ '*' : 1, 'help' : 0, 'markdown' : 0,
            \ }

let g:grammarous#use_vim_spelllang = 1
