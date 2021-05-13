-- ----------------------------------------
-- Platform Specific Configuration
-- ----------------------------------------
local utils = require('utils')
local set_option, has = utils.set_option, utils.has
local set_nvim_variable = utils.set_nvim_variable

if has('gui_running') then
	option('o', 'guioptions', 'egmr')
end


if has('win64') or has('win32') then
	-- Windows
    set_option('o', 'guifont', 'Consolas:h10')

	-- Set height and width on Windows
    set_option('o', 'lines', 80)
    set_option('o', 'columns', 120)

	-- Disable quickfixsigns on Windows due to incredible slowdown.
	set_nvim_variable('g:loaded_quickfixsigns', 1)

	-- Windows has a nasty habit of launching gVim in the wrong working directory
	cmd('cd ~')
elseif has('gui_macvim') then
	-- MacVim

	-- Custom Source Code font for Powerline
	-- From: https://github.com/Lokaltog/powerline-fonts
	set_option('o', 'guifont', 'Source Code Pro for Powerline:h12')
end
