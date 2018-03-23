if exists('g:vim_plug_installing_plugins')
  Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
  finish
endif

" Toggle NERDTree
nmap <silent> <leader>n :NERDTreeToggle<cr>
" expand to the path of the file in the current buffer
nmap <silent> <leader>y :NERDTreeFind<cr>


let g:NERDShutUp=1

let g:NERDTreeShowBookmarks = 1
let g:NERDTreeChDirMode = 0
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMouseMode=1
let g:NERDTreeShowHidden=1

let g:nerdtree_tabs_open_on_gui_startup=0
