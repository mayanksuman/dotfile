if exists('g:vim_plug_installing_plugins')
  Plug 'mayanksuman/vim-notes-markdown'
  finish
endif

let g:note_markdown_dir = '~/Nextcloud/Notes/'
let g:default_notes_extension = '.md'
let g:open_note_dir_in_split = 0
