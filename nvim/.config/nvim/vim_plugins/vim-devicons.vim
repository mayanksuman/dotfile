if exists('g:vim_plug_installing_plugins')
  "icons for files
  Plug 'ryanoasis/vim-devicons'
  finish
endif

" loading the icon plugin 
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_statusline = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 0
let g:WebDevIconsOS = 'Linux'
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:webdevicons_conceal_nerdtree_brackets = 0
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
