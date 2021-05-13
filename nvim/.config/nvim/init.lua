config_file_location = os.getenv("HOME") .. '/.config/nvim/'
runtime_data_location = os.getenv("HOME") .. '/.local/share/nvim/'

local set_option = require('utils').set_option

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
