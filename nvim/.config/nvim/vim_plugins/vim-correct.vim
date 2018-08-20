if exists('g:vim_plug_installing_plugins')
  Plug 'tpope/vim-abolish' "General auto-correction plugin
  Plug 'jdelkins/vim-correction', { 'for': ['markdown','tex','text','textile','git'] } "Require vim-abolish
  finish
endif
