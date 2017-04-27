setlocal spell spelllang=en_us

"Ideas for creating these functions from:
"http://vim-latex.sourceforge.net/documentation/latex-suite/latex-master-file.html#Tex_MainFileExpression
"and
"http://vi.stackexchange.com/questions/2408/vimscript-save-file
"and
"http://stackoverflow.com/questions/890802/how-do-i-disable-the-press-enter-or-type-command-to-continue-prompt-in-vim
function! CompileMasterFile()
	let mainfilename = GetMasterFileName()
	let mainauxfilename = GetMasterFileNameAux()
	if mainfilename != ''
		"save and compile with pdflatex
		:w
		execute ':silent !pdflatex ' mainfilename
		execute ':silent !bibtex ' mainauxfilename
		execute ':silent !bibtex ' mainauxfilename
		execute ':silent !pdflatex ' mainfilename
		execute '!pdflatex ' mainfilename
	else
		"if no master file found, show message
		echom "No master file found (e.g. myfile.tex.latexmaster)"
	endif
endfunction

"we indicate the name of mymain.tex by creating a file mymain.tex.latexmaster,
"which can be empty (or just contain a blank line
function! GetMasterFileName()
	if glob('*.latexmaster') != ''
		"this just removes the '.latexmaster' bit
		return split(glob('*.latexmaster'), ".latexmaster")[0]
	else
		return ''
	endif
endfunction

"in order for bibtex to work, we need the 'mymain.aux' filename
"this seems to be one way to obtain it
function! GetMasterFileNameAux()
	if glob('*.latexmaster') != ''
		"this removes the 'tex.latexmaster' bit and replaces it with 'aux'
		return join([split(glob('*.latexmaster'), ".tex.latexmaster")[0], "aux"], ".")
	else
		return ''
	endif
endfunction

augroup texcmds
	autocmd!
	"need to create a file main.tex.latexmaster, containing one character
	autocmd FileType tex map <buffer> <F7>  :call CompileMasterFile() <CR><CR>
augroup END
