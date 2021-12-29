-- if vim.fn.argc() ~= 0 or vim.fn.line2byte('$') ~= -1 or vim.o.insertmode or not vim.o.modifiable then
--     return
-- end

-- All hotkeys, not dependant on plugins, are mapped here.
require('mappings')

-- All of the Vim configuration.
require('config')

-- Custom commands
require('commands')

-- Load plugin-specific configuration.
require('plugins')

-- Load platform-specific configuration.
require('platforms')

-- Auto commands.
require('autocmds')
