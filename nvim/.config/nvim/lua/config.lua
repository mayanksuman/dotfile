-- ---------------------------------------------
-- Regular Vim Configuration (No Plugins Needed)
-- ---------------------------------------------
local utils = require('utils')
local has, fn = utils.has, utils.fn
local join_path = utils.join_path

-- ---------------
-- Color
-- ---------------
vim.opt.termguicolors = true       -- True color support

-- -----------------------------
-- Backup and Undo behavior
-- -----------------------------
local backupdir = join_path(fn.stdpath('data'), 'backup')
-- nvim do not automatically make backup folder
if fn.empty(fn.glob(backupdir)) > 0 then
    fn.mkdir(backupdir, 'p')
end
vim.opt.backupdir = backupdir       -- Set backup folder
vim.opt.backup = true               -- Turn on backups
vim.opt.writebackup = true          -- Save backup before writing file (failsafe)
-- Persistent Undo
if has('persistent_undo') then
  vim.opt.undofile = true
end

-- ---------------
-- UI
-- ---------------
vim.opt.number = true                  -- Show line numbers
vim.opt.relativenumber = true          -- Relative line numbers
vim.opt.signcolumn = 'auto'            -- Show sign column
vim.opt.wrap = true                    -- Enable line wrap
vim.opt.linebreak = true               -- Do not break words while wrapping
vim.opt.breakindent = true             -- Line Wrap with indent
vim.opt.breakindentopt = 'shift:5'     -- Put five character space before the indented wrap
vim.opt.cursorline = true              -- Highlight current line
vim.opt.colorcolumn = '80'             -- Color the 80th column differently as a wrapping guide.
vim.opt.showmode = false               -- Don't show the mode since Powerline shows it
vim.opt.title = true                   -- Set the title of terminal window to the file

-- ---------------
-- Behaviors
-- ---------------
vim.opt.wildmode = 'list:longest'        -- Command-line completion mode
vim.opt.hidden = true                    -- Enable modified buffers in background
vim.opt.confirm = true                   -- Confirm if you exit without saving
-- clipboard settings inspired by spf13
if has('clipboard') and has('unnamedplus') then
  vim.opt.clipboard = 'unnamed,unnamedplus' -- When possible use + register for copy-paste
else                                                  -- On mac and Windows, use * register for copy-paste
  vim.opt.clipboard = 'unnamed'
end
vim.opt.virtualedit = 'onemore'          -- Allow for cursor till the end of line
vim.opt.whichwrap = 'b,s,h,l,<,>,[,]'    -- Backspace and cursor keys wrap too
vim.opt.pastetoggle = '<F12>'            -- pastetoggle (sane indentation on pastes)
vim.opt.autowrite = true                 -- Writes on make/shell commands
vim.opt.scrolloff = 3                    -- Keep three lines below the last line when scrolling
vim.opt.switchbuf = 'useopen'            -- Switch to an existing buffer if one exists
vim.opt.viewoptions = 'cursor,folds'     -- Only save cursor location and fold in view
vim.opt.fileformat = 'unix'              -- Set file format to unix -- for easier git usage
-- Change the current directory to same as opened file
if fn.argc() ~= 0 and fn.expand('%:p:h') ~= fn.getcwd() then
    vim.cmd('cd %:p:h ')
end
--vim.opt.wildmode = 'list:longest,full' -- Command <Tab> completion, list matches, then longest common part, then all.
--vim.opt.listchars = { space = '_', tab = '>~' }

-- ---------------
-- Text Format
-- ---------------
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.cindent = true
vim.opt.shiftround = true

-- ---------------
-- Searching
-- ---------------
vim.opt.ignorecase = true  -- case insensitive search
vim.opt.smartcase = true   -- case sensitive search if search item has captial letters
vim.opt.wildignore:append{'*.o', '*.obj', '*.exe', '*.so', '*.dll', '*.pyc',
                          '.svn', '.hg','.bzr', '.git', '.sass-cache', '*.class',
                          '*.scssc', '*.cssc', 'sprockets%*', '*.lessc',
                          '*/node_modules/*','rake-pipeline-*'}

-- ---------------
-- Mouse
-- ---------------
vim.opt.mouse = 'a'               -- Mouse in all modes
if has('gui_running') then
    vim.opt.mousehide = true      -- Hide mouse while typing
end

-- ------------------------
-- Python Settings
-- ------------------------
vim.g.python_host_prog = '/usr/bin/python'
vim.g.python3_host_prog = '/usr/bin/python3'
