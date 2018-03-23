if exists('g:vim_plug_installing_plugins')
  Plug 'nathanaelkane/vim-indent-guides'
  finish
endif

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  ctermbg=236 guibg=#202020
hi IndentGuidesEven ctermbg=238 guibg=#333333
