if exists('g:vim_plug_installing_plugins')
  Plug 'mhinz/vim-startify'
  finish
endif

let g:startify_list_order = [
        \ ['   Last modified'],
        \ 'dir',
        \ ['   Recent'],
        \ 'files',
        \ ]
let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ $VIMRUNTIME .'/doc',
            \ 'bundle/.*/doc',
            \ ]
let g:startify_files_number = 15
let g:startify_custom_indices = ['a', 's', 'd', 'f', 'g']
let g:startify_change_to_dir = 0

hi StartifyBracket ctermfg=240
hi StartifyFooter  ctermfg=111
hi StartifyHeader  ctermfg=203
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240

" Keep NERDTree from opening a split when startify is open
autocmd FileType startify setlocal buftype=

let g:startify_recursive_dir = 1
