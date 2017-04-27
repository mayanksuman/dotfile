if exists('g:vim_plug_installing_plugins')
  Plug 'sickill/vim-pasta' " context-aware pasting
  finish
endif

let g:pasta_disabled_filetypes = ['python', 'coffee', 'yaml']
