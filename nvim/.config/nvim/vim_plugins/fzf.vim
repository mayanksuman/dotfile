if exists('g:vim_plug_installing_plugins')
   Plug 'junegunn/fzf', { 'do': './install --all' }
   Plug 'junegunn/fzf.vim'
  finish
endif

nnoremap ff :FZF<CR>
vnoremap ff :FZF<CR>

nnoremap fh :FZF ~<CR>
vnoremap fh :FZF ~<CR>
