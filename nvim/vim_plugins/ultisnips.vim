if exists('g:vim_plug_installing_plugins')
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  finish
endif

let g:UltiSnipsSnippetDirectories=['MyUltiSnippets']
let g:UltiSnipsExpandTrigger='<C-e>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-h>'


" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
