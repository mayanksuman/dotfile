-- ----------------------------------------
-- Auto Commands
-- ----------------------------------------
local utils = require('utils')
local has = utils.has
local create_augroups = utils.create_augroups

programming_filetype = 'c,cpp,java,go,php,javascript,puppet,python,rust,' .. 
                       'twig,xml,yml,perl,sql,html,css,vim,markdown,tex,' ..
                       'coffee,ruby,matlab'


if has('autocmd') then
    local autocmds = {
  MyAutoCommands = {
    {'FocusLost', '*', 'silent! :wa<CR>'},  -- Write all files on focus lost
    {'VimResized', '*', ':wincmd ='},       -- Resize splits when the window is resized
    -- Close Vim if NERDTree is the last buffer
    {'BufEnter', '*', 
        [[if (winnr('$') == 1 && exists('b:NERDTreeType') && b:NERDTreeType == 'primary') | q | endif]]},
    -- save view on buffer write
    {'BufWritePost', '*', 
        [[if expand('%') != '' && &buftype !~ 'nofile'| mkview!| endif]]},    
    -- load view on buffer read
    {'BufRead', '*', 
        [[if expand('%') != '' && &buftype !~ 'nofile'| silent! loadview| endif]]},    
    -- Remove trailing whitespaces and ^M chars
    {'FileType '..programming_filetype..' autocmd BufWritePre', 
        '<buffer>', ':StripTrailingWhitespace'}, 

    {'BufWritePost', '*', 'silent! :syntax sync fromstart<cr>:redraw!<cr>'},
    {'GuiEnter', '*', 'set visualbell t_vb='},
  },


  -- Transparent editing of gpg encrypted files by Wouter Hanegraaff
  -- https://gist.github.com/mrash/0f12560983a8c2888c5f
  encrypted = {
        {'BufReadPre,FileReadPre', '*.gpg', 'set viminfo='},  -- do not write anything to viminfo file
        {'BufReadPre,FileReadPre', '*.gpg', 'set noswapfile noundofile nobackup'},  -- no swap, undo or backup file
        -- use binary mode for reading encrypted files
        {'BufReadPre,FileReadPre', '*.gpg', 'set bin'},  
        {'BufReadPre,FileReadPre', '*.gpg', 'let ch_save = &ch|set ch=2'},  
        {'BufReadPost,FileReadPost', '*.gpg', "'[,']!gpg --decrypt 2> /dev/null"}, -- (If you use tcsh, you may need to alter this line.)
        -- Switch to normal mode for editing
        {'BufReadPost,FileReadPost', '*.gpg', 'set nobin'},
        {'BufReadPost,FileReadPost', '*.gpg', 'let &ch = ch_save|unlet ch_save'},
        {'BufReadPost,FileReadPost', '*.gpg', "execute ':doautocmd BufReadPost ' . expand('%:r')"},
		-- Convert all text to encrypted text before writing
        {'BufWritePre,FileWritePre', '*.gpg', "'[,']!gpg --default-recipient-self -ae 2>/dev/null"}, -- (If you use tcsh, you may need to alter this line.)
		-- Undo the encryption so we are back in the normal text, directly
		-- after the file has been written.
        {'BufWritePost,FileWritePost', '*.gpg', 'u'},  
    },

}

create_augroups(autocmds)
end
