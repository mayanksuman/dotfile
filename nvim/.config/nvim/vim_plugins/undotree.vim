if exists('g:vim_plug_installing_plugins')
  Plug 'mbbill/undotree'
  finish
endif

nnoremap <F5> :UndotreeToggle<cr>
