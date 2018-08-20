if exists('g:vim_plug_installing_plugins')
  Plug 'AndrewRadev/splitjoin.vim' " for making multiline code into single line
  finish
endif

let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
let g:splitjoin_trailing_comma = 1
let g:splitjoin_align = 1

nnoremap <leader>sj :SplitjoinSplit<cr>
nnoremap <leader>sk :SplitjoinJoin<cr>
