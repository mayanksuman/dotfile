if exists('g:vim_plug_installing_plugins')
  Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
  finish
endif

let g:vim_markdown_conceal = 0
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'stylus', 'html', 'python', 'c', 'cpp']
