if exists('g:vim_plug_installing_plugins')
  Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  finish
endif

nnoremap <F5> :UndotreeToggle<cr>
