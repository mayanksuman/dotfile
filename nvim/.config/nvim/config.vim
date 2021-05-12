" ---------------------------------------------
" Regular Vim Configuration (No Plugins Needed)
" ---------------------------------------------

" ---------------
" Color
" ---------------
set termguicolors	" Force true color

" -----------------------------
" File Locations
" -----------------------------
exe 'set backupdir='. g:runtime_data_location. 'backup//,.'
exe 'set directory='. g:runtime_data_location. 'swap//'
exe 'set viewdir='. g:runtime_data_location. 'view//'
let g:netrw_home= g:runtime_data_location
set backup             " Turn on backups
" Persistent Undo
if has('persistent_undo')
	set undofile
	exe 'set undodir='. g:runtime_data_location. 'undo//'
	set undolevels=1000         " Maximum number of changes that can be undone
	set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" ---------------
" UI
" ---------------
set number		" Line numbers on
set wrap		" Line wrapping on
set linebreak	" Do not break words while wrapping
set breakindent		" Line Wrap with indent
set breakindentopt=shift:5  " Put five character space before the indented wrap
set cursorline		" Highlight current line
set noshowmode		" Don't show the mode since Powerline shows it
set title			" Set the title of terminal window to the file
set colorcolumn=80	" Color the 80th column differently as a wrapping guide.

" ---------------
" Behaviors
" ---------------
" Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full
set hidden             " Change buffer - without saving
set confirm            " Enable error files & error jumping.
" clipboard settings inspired by spf13
if has('clipboard') && has('unnamedplus')
	set clipboard=unnamed,unnamedplus " When possible use + register for copy-paste
else         " On mac and Windows, use * register for copy-paste
	set clipboard=unnamed
endif
set virtualedit=onemore             " Allow for cursor till the end of line
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set autowrite          " Writes on make/shell commands
set scrolloff=3        " Keep three lines below the last line when scrolling
set switchbuf=useopen  " Switch to an existing buffer if one exists
set fileformat=unix		" set file format to unix -- for easier git use
" Change the current directory to same as opened file
if !(!argc() && (line2byte('$') == -1))
	cd %:h
end

" ---------------
" Text Format
" ---------------
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set shiftround
set cindent

" ---------------
" Searching
" ---------------
set ignorecase " Case insensitive search
set smartcase  " Non-case sensitive search
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
			\.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,
			\*.lessc,*/node_modules/*,rake-pipeline-*

" ---------------
" Mouse
" ---------------
set mouse=a    " Mouse in all modes
set mousehide  " Hide mouse after chars typed

" ------------------------
" Python Settings
" ------------------------
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'
