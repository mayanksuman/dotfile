if exists('g:vim_plug_installing_plugins')
  Plug 'dsawardekar/ember.vim', { 'for': 'javascript' } 
  finish
endif

nnoremap <leader>ert :Eapp router.coffee<CR>
