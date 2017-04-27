if exists('g:vim_plug_installing_plugins')
  Plug 'chriskempson/base16-vim'
  finish
endif

let base16colorspace=256
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif
