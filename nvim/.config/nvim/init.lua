local utils = require('utils')
local join_path, set_option = utils.join_path, utils.set_option

config_file_location = join_path(os.getenv("HOME"), '.config', 'nvim')
runtime_data_location = join_path(os.getenv("HOME"), '.local', 'share', 'nvim')

set_option('o', 'runtimepath', config_file_location, true)

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
