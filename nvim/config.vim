" ---------------------------------------------
" Regular Vim Configuration (No Plugins Needed)
" ---------------------------------------------

" ---------------
" Color
" ---------------
" Force 256 color mode if available
if $TERM =~ '-256color'
	set t_Co=256
	set t_ut=
endif

set background=dark

" -----------------------------
" File Locations
" -----------------------------
set backup
exe 'set backupdir=.,'. g:runtime_data_location. 'backup'
exe 'set directory='. g:runtime_data_location. 'swap'
exe 'set viewdir='. g:runtime_data_location. 'view'
" Persistent Undo
if has('persistent_undo')
	set undofile
	exe 'set undodir='. g:runtime_data_location. 'undo'
	set undolevels=1000         " Maximum number of changes that can be undone
	set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" ---------------
" UI
" ---------------
set ruler          " Ruler on
set showcmd                 " Show partial commands in status line and
" Selected characters/lines in visual mode
set number         " Line numbers on
set wrap           " Line wrapping on
set breakindent	   " Line Wrap with indent
set breakindentopt=shift:5  " Put five character space before the indented wrap
set laststatus=2   " Always show the statusline
set cmdheight=2    " Make the command area two lines high
set cursorline     " Highlight current line
set encoding=utf-8
set noshowmode     " Don't show the mode since Powerline shows it
set title          " Set the title of the window in the terminal to the file
highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have
" same background color in relative mode
if exists('+colorcolumn')
	set colorcolumn=80 " Color the 80th column differently as a wrapping guide.
endif


" ---------------
" Behaviors
" ---------------
" set path+=**
syntax enable
set backup             " Turn on backups
set autoread           " Automatically reload changes if detected
set wildmenu           " Turn on Wild menu
" Command <Tab> completion, list matches, then longest common part, then all.
set wildmode=list:longest,full
set hidden             " Change buffer - without saving
set history=1000        " Number of things to remember in history.
set confirm            " Enable error files & error jumping.
" clipboard settings inspired by spf13
if has('clipboard')
	if has('unnamedplus')  " When possible use + register for copy-paste
		set clipboard=unnamed,unnamedplus
	else         " On mac and Windows, use * register for copy-paste
		set clipboard=unnamed
	endif
endif
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

set autowrite          " Writes on make/shell commands
set timeoutlen=1000     " Time to wait for a command (after leader for example).
set ttimeout
set ttimeoutlen=100    " Time to wait for a key sequence.
set nofoldenable       " Disable folding entirely.
set foldlevelstart=99  " I really don't like folds.
set formatoptions=crql
set iskeyword+=\$,-   " Add extra characters that are valid parts of variables
set nostartofline      " Don't go to the start of the line after some commands
set scrolloff=3        " Keep three lines below the last line when scrolling
set gdefault           " this makes search/replace global by default
set switchbuf=useopen  " Switch to an existing buffer if one exists

" ---------------
" Text Format
" ---------------
set tabstop=8
set shiftwidth=8 " Tabs under smart indent
set softtabstop=8
set smarttab
set noexpandtab
set shiftround
set backspace=indent,eol,start " Delete everything with backspace
set cindent
set autoindent

" ---------------
" Searching
" ---------------
set ignorecase " Case insensitive search
set smartcase  " Non-case sensitive search
set incsearch  " Incremental search
set hlsearch   " Highlight search results
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
			\.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,
			\*.lessc,*/node_modules/*,rake-pipeline-*

" ---------------
" Visual
" ---------------
set showmatch   " Show matching brackets.
set matchtime=2 " How many tenths of a second to blink
set winminheight=0              " Non Current Windows can be 0 line high
" Show invisible characters
set list

" Reset the listchars
set listchars=""
" make tabs visible and show trailing spaces as dots
set listchars=tab:▸\ ,trail:•
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=extends:>
" The character to show in the last column when wrap is off and the line
" continues beyond the right of the screen
set listchars+=precedes:<

" ---------------
" Sounds
" ---------------
set noerrorbells
set visualbell
set t_vb=

" ---------------
" Mouse
" ---------------
set ttyfast
set mouse=a    " Mouse in all modes
set mousehide  " Hide mouse after chars typed

" Better complete options to speed it up
set complete=.,w,b,u,U
