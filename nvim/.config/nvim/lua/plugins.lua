local utils = require('utils')
local cmd, fn = utils.cmd, utils.fn
local join_path = utils.join_path

-- install packer if it does not exist
local plugins_root = join_path(fn.stdpath('data'), 'site', 'pack')
local packer_path = join_path(plugins_root, 'packer', 'start', 'packer.nvim')
if fn.empty(fn.glob(packer_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
end


local packer = nil
local function init()
    -- load packer and initialize it
    if packer == nil then
        packer = require('packer')
        packer.init({disable_commands = true,
        package_root = plugins_root,
    })
end

local use = packer.use
packer.reset()

-- Main plugings and its configuration
-- Packer can manage itself
use{'wbthomason/packer.nvim'}

-- Base16 colorsheme
use{'chriskempson/base16-vim', config = [[require('plugin_config.base16-vim')]]}

-- Context sensitive increment and decrement
use{'monaqa/dial.nvim'}

-- Quick and easy toggling of quickfix list and the location-list
use{'Valloric/ListToggle', config = [[require('plugin_config.ListToggle')]]}

-- Edit directly from Quickfix list
use{'Olical/vim-enmasse', cmd = 'EnMasse'}

-- Put the text under cursor in focus: good for presenting
use{'junegunn/limelight.vim', cmd = 'Limelight'}

-- Show Marks in signcolumn
use{'kshenoy/vim-signature', config = [[require('plugin_config.signature')]]}

use{'godlygeek/tabular'}            -- align based on character
--use{'gcmt/wildfire.vim'}            -- Fast selection on pressing <CR> in normal mode

-- Fast movement like Easymotion (in lua)
use{'phaazon/hop.nvim', as = 'hop',
config = "require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }"}

-- Async building & commands
use {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

-- Show tags in sidebar
use{'preservim/tagbar', config=[[require('plugin_config.tagbar')]]}

-- Indentation tracking
use{'lukas-reineke/indent-blankline.nvim', branch = 'lua',
    setup = [[require('plugin_config.indentline')]]}

-- For fast editing of html and css files
use{'mattn/emmet-vim', ft={'css','less','sass','scss','html'}}

-- Restore cursor location and fold
use{'vim-scripts/restore_view.vim'}

-- Grammar checking
use{'rhysd/vim-grammarous'}

-- Commenting
use{"terrortylor/nvim-comment", as='nvim_comment',
    config = "require('nvim_comment').setup()"}

-- Wrapping/delimiters
use {'machakann/vim-sandwich',
    {'andymass/vim-matchup', setup = [[require('plugin_config.matchup')]],
    event = 'BufEnter'}
}

-- Excellent tab support (makes the tab concept in vim similar to other
-- editors
use {'romgrk/barbar.nvim', config=[[require('plugin_config.barbar')]]}

-- Start Page
use{'mhinz/vim-startify', config=[[require('plugin_config.vim-startify')]]}

-- Shows different keymapping depending on input
use {"folke/which-key.nvim", config = [[require("plugin_config.which-key")]]}

-- Turn off Search highlight when not needed
-- use 'romainl/vim-cool'

-- Prettification
use {'junegunn/vim-easy-align', config = [[require('plugin_config.easy_align')]]}
use {'mhartington/formatter.nvim', config = [[require('plugin_config.format')]]}

-- Text objects
use 'wellle/targets.vim'

-- Uncover usage problems in your writing
use{'preservim/vim-wordy'}

-- better editing commands in insert mode
use{'preservim/vim-wordchipper'}

-- Search in popups
use{'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}, {'nvim-telescope/telescope-fzy-native.nvim'}},
    setup = [[require('plugin_config.telescope_setup')]],
    config = [[require('plugin_config.telescope')]],
    cmd = 'Telescope'
}

use{'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sql.nvim'}

-- Note taking system based on neuron Zettelkasten concept
use{"oberblastmeister/neuron.nvim", requires={'nvim-lua/plenary.nvim',
'nvim-lua/popup.nvim', 'nvim-telescope/telescope.nvim'}}

-- Undo tree
use{'mbbill/undotree', cmd = 'UndotreeToggle',
    config = [[require('plugin_config.undotree')]]
}

-- Autocorrection
use{'jdelkins/vim-correction', ft={'markdown','text','textile', 'git',
                                   'gitcommit', 'plaintex', 'tex', 'latex',
                                   'rst', 'asciidoc', 'textile', 'pandoc'},
    requires='tpope/vim-abolish'
}

-- Git
use {{'tpope/vim-fugitive', cmd = {'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'}},
    {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'},
    config = "require('gitsigns').setup {}",event = 'BufEnter'},
    {'TimUntersberger/neogit', opt = true}
}

-- Pretty symbols
use{'kyazdani42/nvim-web-devicons',
    config=[[require'nvim-web-devicons'.setup {default = true}]]
}

-- Multiple Cursors
use{'mg979/vim-visual-multi'}

-- Repeat (.) behavior for multiple plugins
use{'tpope/vim-repeat'}

-- Terminal
use{"akinsho/nvim-toggleterm.lua"}

-- REPLs
use{'hkupty/iron.nvim', setup = [[vim.g.iron_map_defaults = 0]],
    config = [[require('plugin_config.iron')]],
    cmd = {'IronRepl', 'IronSend', 'IronReplHere'}
}

-- Completion and linting
use{'neovim/nvim-lspconfig',
requires = {
    'onsails/lspkind-nvim', 'nvim-lua/lsp-status.nvim',
    'glepnir/lspsaga.nvim', 'kabouzeid/nvim-lspinstall'},
    config = [[require('plugin_config.lsp')]]
}

-- Source code highlighting
use {'nvim-treesitter/nvim-treesitter',
    requires = {'nvim-treesitter/nvim-treesitter-refactor', 'nvim-treesitter/nvim-treesitter-textobjects'},
    config = [[require('plugin_config.treesitter')]]
}

-- Rainbow braket and other matches in source code
use{'p00f/nvim-ts-rainbow', requires={'nvim-treesitter/nvim-treesitter'}}

-- Just for tracking progess until this is ready for use
use {'mfussenegger/nvim-lint', opt = true}

-- completion and snippets
use {'hrsh7th/nvim-compe', config = [[require('plugin_config.compe')]], event = 'InsertEnter *'}
-- use {'hrsh7th/vim-vsnip', config = [[require('plugin_config.vsnip')]], event = 'InsertEnter *'}
-- use {'rafamadriz/friendly-snippets'}

-- -- Ultisnips
-- use{'SirVer/ultisnips', config=[[require('plugin_config.ultisnips')]],
-- requires = 'honza/vim-snippets'}

-- Debugger
use {'mfussenegger/nvim-dap', opt = true}
use {'puremourning/vimspector',
    setup = [[vim.g.vimspector_enable_mappings = 'HUMAN']],
    disable = true
}

-- Path navigation
use 'justinmk/vim-dirvish'

-- LaTeX
use {'lervag/vimtex', ft={'tex', 'latex'},
config = [[require('plugin_config.vimtex')]]}

-- Meson
use 'igankevich/mesonic'

-- Highlight colors for hexadecimal color code
use {'norcalli/nvim-colorizer.lua',
    ft = {'css','less','sass','scss','html','javascript','python','stylus'},
    config = [[require('colorizer').setup {'css','less','sass','scss','html','javascript','python','stylus'}]]
}

-- Easier moving in tabs and windows with '<c-h/j/k/l>' is supported by
-- vim-tmux-navigator plugin.
use{'christoomey/vim-tmux-navigator'}
end

-- Command for package management
cmd("command! PackerInstall packadd packer.nvim | lua require('plugins').install()")
cmd("command! PackerUpdate packadd packer.nvim | lua require('plugins').update()")
cmd("command! PackerSync packadd packer.nvim | lua require('plugins').sync()")
cmd("command! PackerClean packadd packer.nvim | lua require('plugins').clean()")
cmd("command! PackerCompile packadd packer.nvim | lua require('plugins').compile()")

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
