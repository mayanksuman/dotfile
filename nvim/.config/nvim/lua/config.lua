-- ---------------------------------------------
-- Regular Vim Configuration (No Plugins Needed)
-- ---------------------------------------------
local utils = require('utils')
local set_option, has, fn = utils.set_option, utils.has, utils.fn
local set_nvim_variable = utils.set_nvim_variable
local join_path = utils.join_path

-- ---------------
-- Color
-- ---------------
set_option('o', 'termguicolors', true)                       -- True color support

-- -----------------------------
-- Backup and Undo behavior
-- -----------------------------
local backupdir = join_path(fn.stdpath('data'), 'backup')
-- nvim do not automatically make backup folder
if fn.empty(fn.glob(backupdir)) > 0 then
    fn.mkdir(backupdir, 'p')
end
set_option('o', 'backupdir', backupdir)
set_option('o', 'backup', true)             -- Turn on backups
set_option('o', 'writebackup', true)        -- Save backup before writing file (failsafe)
-- Persistent Undo
if has('persistent_undo') then
  set_option('b', 'undofile', true)
end

-- ---------------
-- UI
-- ---------------
set_option('w', 'number', true)                  -- Show line numbers
set_option('w', 'relativenumber', true)          -- Relative line numbers
set_option('w', 'signcolumn', 'auto')           -- Show sign column
set_option('w', 'wrap', true)                    -- Enable line wrap
set_option('w', 'linebreak', true)               -- Do not break words while wrapping
set_option('w', 'breakindent', true)             -- Line Wrap with indent
set_option('w', 'breakindentopt', 'shift:5')     -- Put five character space before the indented wrap
set_option('w', 'cursorline', true)              -- Highlight current line
set_option('w', 'colorcolumn', '80')               -- Color the 80th column differently as a wrapping guide.
set_option('o', 'showmode', false)               -- Don't show the mode since Powerline shows it
set_option('o', 'title', true)                   -- Set the title of terminal window to the file

-- ---------------
-- Behaviors
-- ---------------
set_option('o', 'wildmode', 'list:longest')        -- Command-line completion mode
set_option('o', 'hidden', true)                    -- Enable modified buffers in background
set_option('o', 'confirm', true)                   -- Confirm if you exit without saving
-- clipboard settings inspired by spf13
if has('clipboard') and has('unnamedplus') then
  set_option('o', 'clipboard', 'unnamed,unnamedplus') -- When possible use + register for copy-paste
else         -- On mac and Windows, use * register for copy-paste
  set_option('o', 'clipboard', 'unnamed')
end
set_option('o', 'virtualedit', 'onemore')          -- Allow for cursor till the end of line
set_option('o', 'whichwrap', 'b,s,h,l,<,>,[,]')    -- Backspace and cursor keys wrap too
set_option('o', 'pastetoggle', '<F12>')            -- pastetoggle (sane indentation on pastes)
set_option('o', 'autowrite', true)                 -- Writes on make/shell commands
set_option('o', 'scrolloff', 3)                    -- Keep three lines below the last line when scrolling
set_option('o', 'switchbuf', 'useopen')            -- Switch to an existing buffer if one exists
set_option('o', 'viewoptions', "cursor,folds")     -- Only save cursor location and fold in view
set_option('b', 'fileformat', 'unix')              -- set file format to unix -- for easier git use
-- Change the current directory to same as opened file
if fn.argc() ~= 0 and fn.expand('%:p:h') ~= fn.getcwd() then
	vim.cmd('cd %:p:h ')
end
--set wildmode=list:longest,full -- Command <Tab> completion, list matches, then longest common part, then all.

-- ---------------
-- Text Format
-- ---------------
set_option('b', 'tabstop', 4)
set_option('b', 'shiftwidth', 4)
set_option('b', 'softtabstop', 4)
set_option('b', 'expandtab', true)
set_option('b', 'cindent', true)
set_option('o', 'shiftround', true)

-- ---------------
-- Searching
-- ---------------
set_option('o', 'ignorecase', true)  -- case insensitive search
set_option('o', 'smartcase', true)  -- case sensitive search if search item has captial letters
set_option('o', 'wildignore', '*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,' ..
                       '.git,.sass-cache,*.class,*.scssc,*.cssc,' ..
                       'sprockets%*,*.lessc,*/node_modules/*,' ..
		       'rake-pipeline-*', true)

-- ---------------
-- Mouse
-- ---------------
set_option('o', 'mouse', 'a')          -- Mouse in all modes
if has('gui_running') then
    set_option('o', 'mousehide', true)     -- Hide mouse while typing
end

-- ------------------------
-- Python Settings
-- ------------------------
set_nvim_variable('g:python_host_prog', '/usr/bin/python')
set_nvim_variable('g:python3_host_prog', '/usr/bin/python3')
