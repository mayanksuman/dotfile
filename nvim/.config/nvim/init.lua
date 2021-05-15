local utils = require('utils')
local join_path, set_option = utils.join_path, utils.set_option

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
