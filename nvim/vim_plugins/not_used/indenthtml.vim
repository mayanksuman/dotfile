if exists('g:vim_plug_installing_plugins')
  Plug 'indenthtml.vim', { 'for': 'html' } " html indent support
  finish
endif

" Setup indenthtml to propertly indent html. Without this, formatting doesn't
" work on html.
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
