if exists('g:vim_plug_installing_plugins')
  Plug 'fatih/vim-go', { 'for': 'go' , 'do': ':GoInstallBinaries' } " go support
  finish
endif
