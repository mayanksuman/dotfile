if exists('g:vim_plug_installing_plugins')
  if has('nvim')
Plug 'roxma/nvim-completion-manager'
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
  finish
endif

