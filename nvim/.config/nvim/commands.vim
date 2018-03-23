" ----------------------------------------
" Commands
" ----------------------------------------

" Silently execute an external command
" No 'Press Any Key to Contiue BS'
" from: http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts
command! -nargs=1 SilentCmd
			\ | execute ':silent !'.<q-args>
			\ | execute ':redraw!'

command! MakeTags !ctags -R .


" Fixes common typos
command! W w
command! Wq wq
command! Q q
