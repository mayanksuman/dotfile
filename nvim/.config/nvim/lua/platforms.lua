-- ----------------------------------------
-- Platform Specific Configuration
-- ----------------------------------------
local utils = require('utils')
local has = utils.has

if has('gui_running') then
    vim.opt.guioptions = 'egmr'
end


if has('win64') or has('win32') then
    -- Windows
    vim.opt.guifont = 'Consolas:h10'

    -- Set height and width on Windows
    vim.opt.lines = 80
    vim.opt.columns = 120

    -- Disable quickfixsigns on Windows due to incredible slowdown.
    vim.g.loaded_quickfixsigns = 1

    -- Windows has a nasty habit of launching gVim in the wrong working directory
    cmd('cd ~')
elseif has('gui_macvim') then
    -- MacVim

    -- Custom Source Code font for Powerline
    -- From: https://github.com/Lokaltog/powerline-fonts
    vim.opt.guifont = 'Source Code Pro for Powerline:h12'
end
