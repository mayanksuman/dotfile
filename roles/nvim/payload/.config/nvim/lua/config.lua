-- ---------------------------------------------
-- Regular Vim Configuration (No Plugins Needed)
-- ---------------------------------------------
local utils = require('utils')
local has, fn, cmd = utils.has, utils.fn, utils.cmd
local join_path = utils.join_path
local opt = vim.opt

-- ---------------
-- Color
-- ---------------
opt.termguicolors = true       -- True color support

-- -----------------------------
-- Backup and Undo behavior
-- -----------------------------
local backupdir = join_path(fn.stdpath('data'), 'backup')
-- nvim do not automatically make backup folder
if fn.empty(fn.glob(backupdir)) > 0 then
    fn.mkdir(backupdir, 'p')
end
opt.backupdir = backupdir       -- Set backup folder
opt.backup = true               -- Turn on backups
opt.writebackup = true          -- Save backup before writing file (failsafe)
-- Persistent Undo
if has('persistent_undo') then
  opt.undofile = true
end

-- ---------------
-- UI
-- ---------------
opt.number = true                  -- Show line numbers
opt.relativenumber = true          -- Relative line numbers
opt.signcolumn = 'auto'            -- Show sign column
opt.wrap = true                    -- Enable line wrap
opt.linebreak = true               -- Do not break words while wrapping
opt.breakindent = true             -- Line Wrap with indent
opt.breakindentopt = 'shift:5'     -- Put five character space before the indented wrap
opt.colorcolumn = '80'             -- Color the 80th column differently as a wrapping guide.
opt.showmode = false               -- Don't show the mode since Powerline shows it
opt.title = true                   -- Set the title of terminal window to the file

-- cursorline behavior
opt.cursorline = true              -- Highlight current line
-- Only have cursorline on in the active buffer
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- ---------------
-- Behaviors
-- ---------------
opt.confirm = true                   -- Confirm if you exit without saving
-- clipboard settings inspired by spf13
if has('clipboard') and has('unnamedplus') then
  opt.clipboard = 'unnamed,unnamedplus'         -- When possible use + register for copy-paste
else                                            -- On mac and Windows, use * register for copy-paste
  opt.clipboard = 'unnamed'
end
opt.virtualedit = 'onemore'          -- Allow for cursor till the end of line
opt.whichwrap = 'b,s,h,l,<,>,[,]'    -- Backspace and cursor keys wrap too
opt.autowrite = true                 -- Writes on make/shell commands
opt.scrolloff = 10                   -- Keep 10 lines below the last line when scrolling
opt.switchbuf = 'useopen'            -- Switch to an existing buffer if one exists
opt.viewoptions = 'cursor,folds'     -- Only save cursor location and fold in view
opt.fileformat = 'unix'              -- Set file format to unix -- for easier git usage
-- Change the current directory to same as opened file
if fn.argc() ~= 0 and fn.expand('%:p:h') ~= fn.getcwd() then
    cmd('cd %:p:h ')
end
--vim.opt.listchars = { space = '_', tab = '>~' }
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, do not continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- Use the indent of the first line in paragraph.
opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }

-- ---------------
-- Text Format
-- ---------------
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.cindent = true
opt.shiftround = true

-- ---------------
-- Spell
-- ---------------
opt.spelllang = 'en_us'
opt.spell = true
opt.syntax = 'enable'     -- check spelling for comments only

-- ---------------
-- Completion
-- ---------------
opt.completeopt = { "menu", "longest" }
opt.shortmess:append "c"            -- Don't show match information in status bar
opt.pumblend = 10                   -- somewhat transparent popup

-- --------------------
-- Search and Replace
-- --------------------
opt.ignorecase = true  -- case insensitive search
opt.smartcase = true   -- case sensitive search if search item has captial letters
opt.wildignore:append{'*.o', '*.obj', '*.exe', '*.so', '*.dll', '*.pyc',
                          '*pycache*', '.svn', '.hg','.bzr', '.git',
                          '.sass-cache', '*.class', '*.scssc', '*.cssc',
                          'sprockets%*', '*.lessc',
                          '*/node_modules/*','rake-pipeline-*'}
opt.inccommand = 'split'

-- ---------------
-- Mouse
-- ---------------
opt.mouse = 'a'               -- Mouse in all modes
if has('gui_running') then
    opt.mousehide = true      -- Hide mouse while typing
end

-- ------------------------
-- Python Settings
-- ------------------------
vim.g.python_host_prog = '/usr/bin/python'
vim.g.python3_host_prog = '/usr/bin/python3'

-- Use only filetype.lua (not filetype.vim) for filetype detection - leads to faster loading
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0
