if exists('g:vim_plug_installing_plugins')
  Plug 'benekastah/neomake'
  finish
endif

autocmd! BufWritePost * Neomake

let g:neomake_list_height = 5

function! SetJavaScriptCheckers()
  let checkers = []

  if findfile('.eslintrc', '.;') != ''
    call add(checkers, 'eslint')
  endif

  if findfile('.jshintrc', '.;') != ''
    call add(checkers, 'jshint')
  endif

  if findfile('.jscsrc', '.;') != ''
    call add(checkers, 'jscs')
  endif

  if finddir('ProjectSettings', '.;') != ''
    call add(checkers, 'unityscript')
  endif

  let g:neomake_javascript_enabled_makers = checkers
endfunction

autocmd FileType javascript call SetJavaScriptCheckers()
