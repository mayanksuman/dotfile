-- ----------------------------------------
-- Auto Commands
-- ----------------------------------------
local utils = require('utils')
local has = utils.has
local programming_filetypes = table.concat(utils.programming_filetypes, ',')
local set_augroup = utils.set_augroup


if has('autocmd') then
    local autocmds = {
        MyAutoCommands = {
            {event='FocusLost', option={['*']='silent! :wa<CR>'}},  -- Write all files on focus lost
            {event='VimResized', option={['*']=':wincmd ='}},       -- Resize splits when the window is resized
            -- Close Vim if NERDTree is the last buffer
            {event='BufEnter', option={['*']="if (winnr('$') == 1 && exists('b:NERDTreeType') && b:NERDTreeType == 'primary') | q | endif"}},
            -- Remove trailing whitespaces and ^M chars
            {event='FileType', option={[programming_filetypes]='autocmd BufWritePre <buffer> :StripTrailingWhitespace'}},
            -- apply syntax highlighting after writing the file
            {event='BufWritePost', option={['*']='silent! :syntax sync fromstart<cr>:redraw!<cr>'}},
            {event='GuiEnter', option={['*']='set visualbell t_vb='}},  -- Disable visual bell in case of GUI
        },

        -- Transparent editing of gpg encrypted files by Wouter Hanegraaff
        -- https://gist.github.com/mrash/0f12560983a8c2888c5f
        encrypted = {
            {event={'BufReadPre','FileReadPre'}, option={['*.gpg']='set viminfo='}},  -- do not write anything to viminfo file
            {event={'BufReadPre','FileReadPre'}, option={['*.gpg']='set noswapfile noundofile nobackup'}},  -- no swap, undo or backup file
            -- use binary mode for reading encrypted files
            {event={'BufReadPre','FileReadPre'}, option={['*.gpg']='set bin'}},
            {event={'BufReadPre','FileReadPre'}, option={['*.gpg']='let ch_save = &ch|set ch=2'}},
            {event={'BufReadPost','FileReadPost'}, option={['*.gpg']="'[,']!gpg --decrypt 2> /dev/null"}}, -- (If you use tcsh, you may need to alter this line.)
            -- Switch to normal mode for editing
            {event={'BufReadPost','FileReadPost'}, option={['*.gpg']='set nobin'}},
            {event={'BufReadPost','FileReadPost'}, option={['*.gpg']='let &ch = ch_save|unlet ch_save'}},
            {event={'BufReadPost','FileReadPost'}, option={['*.gpg']="execute ':doautocmd BufReadPost ' . expand('%:r')"}},
            -- Convert all text to encrypted text before writing
            {event={'BufWritePre','FileWritePre'}, option={['*.gpg']="'[,']!gpg --default-recipient-self -ae 2>/dev/null"}}, -- (If you use tcsh, you may need to alter this line.)
            -- Undo the encryption so we are back in the normal text, directly
            -- after the file has been written.
            {event={'BufWritePost','FileWritePost'}, option={['*.gpg']='u'}},
        },
    }

    set_augroup(autocmds)
end
