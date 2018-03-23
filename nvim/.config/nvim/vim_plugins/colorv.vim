if exists('g:vim_plug_installing_plugins')
  Plug 'Rykka/colorv.vim', { 'for': ['css','less','sass','scss','javascript','python','stylus'] }
  finish
endif

let g:colorv_preview_ftype = 'css,javascript,scss,sass,python,stylus'
let g:colorv_cache_file=g:runtime_data_location . 'vim_colorv_cache'
let g:colorv_cache_fav=g:runtime_data_location . 'vim_colorv_cache_fav'
