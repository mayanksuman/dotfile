if exists('g:vim_plug_installing_plugins')
  Plug 'wilywampa/vim-ipython', { 'for': ['ipynb', 'ipython'] }
  Plug 'vyzyv/vimpyter', { 'for': ['ipynb', 'ipython'] }
  finish
endif

autocmd Filetype ipynb nmap <silent><Leader>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>
autocmd Filetype ipynb nmap <silent><Leader>n :VimpyterStartNteract<CR>
