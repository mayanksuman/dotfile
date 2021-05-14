-- ----------------------------------------
-- Mapping Configuration
-- ----------------------------------------
local utils = require('utils')
local has, fn = utils.has, utils.fn
local set_nvim_variable = utils.set_nvim_variable
local set_keymap = utils.set_keymap
local normal_mode_set_keymap = utils.normal_mode_set_keymap
local insert_mode_set_keymap = utils.insert_mode_set_keymap
local visual_mode_set_keymap = utils.visual_mode_set_keymap
local commandline_mode_set_keymap = utils.commandline_mode_set_keymap
local terminal_mode_set_keymap = utils.terminal_mode_set_keymap
local leader_keymap_table = utils.leader_keymap_table

-- Set leader to ,
-- Note: This line MUST come before any <leader> mappings
set_nvim_variable('g:mapleader', ',')
set_nvim_variable('b:mapleader', ',')
set_nvim_variable('g:maplocalleader', ' ')
set_nvim_variable('b:maplocalleader', ' ')

-- ---------------
-- Usability Mappings
-- ---------------
normal_mode_set_keymap({
        Y='y$', -- Make Y behave like other capital commands. Yank from the cursor to the end of the line, consistent with C and D.
        n='nzz', -- show forward search result in the middle of screen
        N='Nzz', -- show backward search result in the middle of screen
        go='o<Esc>k', -- Create newlines without entering insert mode
        gO='O<Esc>k', -- Create newlines without entering insert mode
        gj='15gjzz', -- Scroll larger amounts with gj / gk
        gk='15gkzz', -- Scroll larger amounts with gj / gk
        ['*']=':let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>', -- Don't move on *
    }
    )
-- Wrapped lines goes down/up to next row, rather than next line in file.
set_keymap('', {j='gj', k='gk'})

insert_mode_set_keymap({['<C-l>']='<C-x><C-l>', -- Make line completion easier.
        ['<C-t>']='<c-g>u<Esc>[s1z=`]a<c-g>u', -- Correct typos and return back to starting position in insert mode
        jj='<Esc>', -- Let's make escape better.
        jJ='<Esc>',
        Jj='<Esc>',
        JJ='<Esc>',
    })

visual_mode_set_keymap({gj='15gjzz', -- Scroll larger amounts with gj / gk
        gk='15gkzz', -- Scroll larger amounts with gj / gk
        ['<']= '<gv', -- Visual shifting (does not exit Visual mode)
        ['>']= '>gv', -- Visual shifting (does not exit Visual mode)
        ['.']= ':normal .<CR>', -- Allow using the repeat operator with a visual mode
    })

-- ---------------
-- Window Movement
-- ---------------
-- Easier moving in tabs and windows
-- The lines conflict with the default digraph mapping of <C-K>
set_keymap('', {['<c-h>']='<c-w>h',    -- goto left window
        ['<c-j>']='<c-w>j',     -- goto bottom window
        ['<c-k>']='<c-w>k',     -- goto upper window
        ['<c-l>']='<c-w>l',     -- goto right window
        ['<leader>=']='<C-w>=', --Equal window size
    })

-- Close the current window
normal_mode_set_keymap({['<m-w>']=':close<CR>'})

-- ---------------
-- Leader Mappings
-- ---------------
set_keymap('', leader_keymap_table({['/'] =':nohls<CR>'}))  -- clear search

normal_mode_set_keymap(leader_keymap_table(
   {['h']='*<c-o>', -- highlight search word under cursor without jumping to next
    ['sp']=':set spell!<cr>', -- toggle spelling mode
    [',']=':b#<cr>', -- quickly switch to last buffer
    ['ul']=[[::t.\|s/./-/\|:nohls<cr>]], -- underline the current line with '-'
    ['uul']=[[::t.\|s/./=/\|:nohls<cr>]], -- underline the current line with '='
    ['fef']="mx=ggg='x", -- format the entire file
    ['fj']=":%!underscore print<cr><esc>:set filetype=json<cr>", -- format a json file with underscore cli
    }))

-- Surround the commented line with lines. Example:
--          # Test 123
--          becomes
--          # --------
--          # Test 123
--          # --------
normal_mode_set_keymap(leader_keymap_table(
    {['cul']=':normal --lyy--lpwvLr-^--lyyk--lP<CR>'}))

-- Code folding options: pressing <leader>f0 set folding level to 0 and so on
-- till f9. Beware: these are not function keys
folding_keys = {}
for i = 0, 9 do
    folding_keys['f'..i] = ':set foldlevel='..i..'<CR>'
end
normal_mode_set_keymap(leader_keymap_table(folding_keys), {silent=true})

-- Find merge conflict markers
set_keymap('', leader_keymap_table({fc=[[/\v^[<\|=>]{7}( .*\|$)<CR>]]}), {})

-- Some helpers to edit mode
-- http://vimcasts.org/e/14
commandline_mode_set_keymap({['%%']="<C-R>=fnameescape(expand('%:h')).'/'<CR>"}, 
                {noremap=true})
set_keymap('', leader_keymap_table({ew = ':e %%',   -- edit parent directory
                                    es = ':sp %%',  -- edit parent directory in horizontal split
                                    ev = ':vsp %%', -- edit parent directory in vertical split
                                    et = ':tabe %%',-- edit parent directory in tab
                                }),{})

-- copy current file name (relative/absolute) to system clipboard
-- from http://stackoverflow.com/a/17096082/22423
normal_mode_set_keymap(leader_keymap_table({
                                        yp =':let @*=expand(--%--)<CR>',        -- relative path  (src/foo.txt)
                                        yP =':let @*=expand(--%:p--)<CR>',      -- absolute path  (/something/src/foo.txt)
                                        yf =':let @*=expand(--%:t--)<CR>',      -- filename  (foo.txt)
                                        yd =':let @*=expand(--%:p:h--)<CR>',    -- directory name  (/something/src)
                                    }))

-- Easy diff merging (git merge)
set_keymap('', leader_keymap_table(
                    {gdc=[[:diffget //2\|diffupdate<CR>]],   --accept the diff from current branch
                    gdm=[[:diffget //3\|diffupdate<CR>]],    --accept the diff from merging branch
            }), {})

-- Easier formatting
normal_mode_set_keymap(leader_keymap_table({f='gwip'}))

-- git blame support
visual_mode_set_keymap(leader_keymap_table({
    b=[[:<C-U>!git blame <C-R>=expand(--%:p--) <CR> \| sed -n <C-R>=line(--'<--) <CR>,<C-R>=line(--'>--) <CR>p <CR>]]
}), {})

-- ---------------
-- -- Typo Fixes
-- -- ---------------

set_keymap('', {['<F1>']='<Esc>'})
insert_mode_set_keymap({['<F1>']='<Esc>'})
commandline_mode_set_keymap({["w'"] = 'w<CR>'})
                    
-- Disable the ever-annoying Ex mode shortcut key.
-- make Q repeat the last macro instead. *hat tip* http://vimbits.com/bits/263
normal_mode_set_keymap({Q='@@'})

--[[
    -- Paste and select pasted
    vim.api.nvim_set_keymap('n', 'gpp', '`[' . strpart(getregtype(), 0, 1) . '`]', {expr=true, noremap=true, silent=true})
    nnoremap <expr> gpp '`[' . strpart(getregtype(), 0, 1) . '`]'

    -- Insert date
    iabbrev ddate <C-R>=strftime(--%Y-%m-%d--)<CR>
    ]]


-- For when you forget to sudo.. Really Write the file.
commandline_mode_set_keymap({['w!!'] = 'w !sudo tee % > /dev/null'}, {})

-- Mapping for NVIM only
if has('nvim') then
    -- Terminal emulator mapping for nvim
    -- Escape key behavior
    terminal_mode_set_keymap({jk=[[<C-\><C-n>]], 
                              JK=[[<C-\><C-n>]],
                              Jk=[[<C-\><C-n>]],
                              jK=[[<C-\><C-n>]], 
                       ['<Esc>']=[[<C-\><C-n>]]})

    -- Movement across panes
    terminal_mode_set_keymap({['<C-h>']=[[<C-\><C-n><C-w>h]],
                              ['<C-j>']=[[<C-\><C-n><C-w>j]], 
                              ['<C-k>']=[[<C-\><C-n><C-w>k]], 
                              ['<C-l>']=[[<C-\><C-n><C-w>l]],
            }) 
end
