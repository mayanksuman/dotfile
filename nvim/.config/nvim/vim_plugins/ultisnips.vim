if exists('g:vim_plug_installing_plugins')
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  finish
endif

exe 'let g:UltiSnipsSnippetDirectories=['''.g:config_file_location.'MyUltiSnippets'',''MyUltiSnippets'']'
let g:UltiSnipsExpandTrigger='<C-e>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'


" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
