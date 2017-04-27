if exists('g:vim_plug_installing_plugins')
   Plug 'junegunn/fzf', { 'do': './install --all' }
   Plug 'junegunn/fzf.vim'
  finish
endif

nnoremap fzf :FZF<CR>
vnoremap fzf :FZF<CR>

nnoremap fzh :FZF ~<CR>
vnoremap fzh :FZF ~<CR>


