local utils = require('utils')
local cmd, fn = utils.cmd, utils.fn
local join_path = utils.join_path
local programming_filetypes = utils.programming_filetypes
local text_filetypes = utils.text_filetypes

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

-- Packer can manage itself
use{'wbthomason/packer.nvim'}    -- package manager itself

-- ============================================================================
-- Other Plugins and their configuration

-------------------------------------------------------------------------------
-- UI look and functionality
-------------------------------------------------------------------------------
use{'dracula/vim', config = [[require('plugin_config.dracula')]]}             -- dracula theme
use{'hoob3rt/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons'}        -- status bar
use{'mhinz/vim-startify', config=[[require('plugin_config.vim-startify')]]}   -- Start Page
use{'sunjon/shade.nvim', config = [[require('plugin_config.shade')]]}         -- shade the inactive window
use{'vim-scripts/restore_view.vim'}                                           -- Restore cursor location and fold
-- Shows different keymapping depending on input
use{"folke/which-key.nvim", config = [[require("plugin_config.which-key")]]}
-- Quick and easy toggling of quickfix list and the location-list
use{'Valloric/ListToggle', config = [[require('plugin_config.ListToggle')]]}
-- Put the text under cursor in focus: good for presenting
use{'junegunn/limelight.vim', cmd = 'Limelight'}
-- Show user-set marks in the file in signcolumn
use{'kshenoy/vim-signature', config = [[require('plugin_config.signature')]]}
-- Fast movement like Easymotion (in lua)
use{'phaazon/hop.nvim', as = 'hop',
    config = "require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }"}
-- Indentation tracking
use{'lukas-reineke/indent-blankline.nvim',
    setup = [[require('plugin_config.indentline')]],
    event = BufEnter}
-- popup windows for search and other things
use{'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-fzy-native.nvim'},
    setup = [[require('plugin_config.telescope_setup')]],
    config = [[require('plugin_config.telescope')]],
    module = "telescope",
    cmd = 'Telescope'
}
use{'nvim-lua/plenary.nvim', module = 'plenary'}  -- lua functions used by other plugins
use{'nvim-telescope/telescope-frecency.nvim',    -- sort filenames in telescope by access frequency
    requires = {'tami5/sql.nvim', 'nvim-telescope/telescope.nvim'}}
-- Pretty symbols
use{'kyazdani42/nvim-web-devicons', module = "nvim-web-devicons", opt = true,
    config=[[require'nvim-web-devicons'.setup {default = true}]]
}
-- Directory tree at the side
use{'kyazdani42/nvim-tree.lua', config=[[require('plugin_config.nvim-tree')]]}
use{'mg979/vim-visual-multi'}     -- Multiple Cursors
use{'tpope/vim-repeat'}           -- Repeat (.) behavior for multiple plugins
use{"akinsho/nvim-toggleterm.lua"} -- Easy terminal toggling
-------------------------------------------------------------------------------

    
-------------------------------------------------------------------------------
-- Plugins for editing 
-------------------------------------------------------------------------------
use{'monaqa/dial.nvim', event = 'BufEnter'}         -- Context sensitive increment and decrement
use{'Olical/vim-enmasse', cmd = 'EnMasse'}          -- Edit directly from Quickfix list
use{'rhysd/vim-grammarous'}                         -- Grammar checking
use{'mbbill/undotree', cmd = 'UndotreeToggle',      -- Undo tree
    config = [[require('plugin_config.undotree')]]}
use{'mattn/emmet-vim',                              -- For fast editing of html and css files 
    ft={'css','less','sass','scss','html'}}
use{"terrortylor/nvim-comment",                     -- Commenting
    as='nvim_comment',
    config = "require('nvim_comment').setup()"}
use{'jdelkins/vim-correction', ft = text_filetypes, -- Autocorrection 
    requires='tpope/vim-abolish'}
-- Wrapping/delimiters
use{"blackCauldron7/surround.nvim",
    config = [[require"surround".setup {mappings_style = "surround"}]]
}
use{'windwp/nvim-autopairs', event = 'InsertEnter', opt = true}
-- Text objects
use{'wellle/targets.vim'}
-- Uncover usage problems in your writing
use{'preservim/vim-wordy', ft = text_filetypes}
-- better editing commands in insert mode
use{'preservim/vim-wordchipper'}
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Plugins for formatting
-------------------------------------------------------------------------------
use{'junegunn/vim-easy-align', keys = "<Plug>(EasyAlign)",
    config = [[require('plugin_config.easy_align')]]}
use{'mhartington/formatter.nvim', config = [[require('plugin_config.format')]]}
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Plugins for IDE functionality
-------------------------------------------------------------------------------
-- Async building & commands
use {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
-- Show tags in sidebar
use{'preservim/tagbar', config=[[require('plugin_config.tagbar')]]}
-- REPLs
use{'hkupty/iron.nvim', setup = [[vim.g.iron_map_defaults = 0]],
    config = [[require('plugin_config.iron')]],
    cmd = {'IronRepl', 'IronSend', 'IronReplHere'}
}
-- LSP and linting support
use{'neovim/nvim-lspconfig',
    requires = {'onsails/lspkind-nvim', 'nvim-lua/lsp-status.nvim', -- helps in getting info from LSP for statusbar
                'glepnir/lspsaga.nvim', 'kabouzeid/nvim-lspinstall'},
    config = [[require('plugin_config.lsp')]],
}
-- Source code highlighting
use {'nvim-treesitter/nvim-treesitter',
    requires = {'nvim-treesitter/nvim-treesitter-refactor',
                'nvim-treesitter/nvim-treesitter-textobjects'},
    config = [[require('plugin_config.treesitter')]],
    ft = programming_filetypes,
    module = 'nvim-treesitter',
}
-- Rainbow braket and other matches in source code
use{'p00f/nvim-ts-rainbow', requires={'nvim-treesitter/nvim-treesitter'},
    config = [[require('plugin_config.nvim-ts-rainbow')]],
    after = 'nvim-treesitter',
    ft = programming_filetypes,
}
-- Just for tracking progess until this is ready for use
use {'mfussenegger/nvim-lint', opt = true}
-- completion and snippets
use{"hrsh7th/nvim-cmp",
    requires = {
        {'hrsh7th/cmp-nvim-lsp'},    -- Source nvim LSP
        {'hrsh7th/cmp-buffer'},      -- Source the current buffer
        {'hrsh7th/cmp-path'},        -- Source for filesystem paths
        {'hrsh7th/cmp-nvim-lua'},    -- Source for vim lua functions
        {'hrsh7th/cmp-calc'},        -- Source for math calculation
        {'hrsh7th/cmp-emoji'},       -- Source for emoji
        {'L3MON4D3/LuaSnip'},        -- Snippets plugin
        {'rafamadriz/friendly-snippets'}, -- collection of snippets
        {'saadparwaiz1/cmp_luasnip'},-- Source for snippets (from LuaSnip)
        {'tzachar/cmp-tabnine',      -- TabNine support for faster code writing
        run = './install.sh',
        },
        --{'ray-x/lsp_signature.nvim'}, -- Show function signature when you type from LSP
        {'onsails/lspkind-nvim'},       -- For symbols in completion drop-down menu
    },
    config = [[require('plugin_config.completion')]],
    module = 'cmp'
    --event = "InsertEnter",
}
-- Debugger
use{'mfussenegger/nvim-dap', opt = true, ft=programming_filetypes}
use{'puremourning/vimspector',
    setup = [[vim.g.vimspector_enable_mappings = 'HUMAN']],
    disable = true,
    ft = programming_filetypes
}
-- LaTeX
use{'lervag/vimtex', ft={'tex', 'latex'},
    config = [[require('plugin_config.vimtex')]]
}
-- Meson
use{'igankevich/mesonic'}
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Plugins with utility value
-------------------------------------------------------------------------------
-- Note taking system based on neuron Zettelkasten concept
use{"oberblastmeister/neuron.nvim",
    requires={'nvim-lua/plenary.nvim',
              'nvim-lua/popup.nvim',
              'nvim-telescope/telescope.nvim'
           }
}
-- Git support
use {{'tpope/vim-fugitive', cmd = {'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'}},
    {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'},
    config = "require('gitsigns').setup {}",event = 'BufEnter'},
    {'TimUntersberger/neogit', opt = true}
}
-- Highlight colors for hexadecimal color code
use{'norcalli/nvim-colorizer.lua',
    ft = {'css','less','sass','scss','html','javascript','python','stylus'},
    config = [[require('colorizer').setup {'css','less','sass','scss','html','javascript','python','stylus'}]]
}
-- Easier moving in tabs and windows with '<c-h/j/k/l>' is supported by
-- vim-tmux-navigator plugin.
use{'christoomey/vim-tmux-navigator'}
-------------------------------------------------------------------------------
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
