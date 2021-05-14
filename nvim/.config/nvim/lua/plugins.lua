local utils = require('utils')
local cmd, fn = utils.cmd, utils.fn
local join_path = utils.join_path
local deepcopy = utils.deepcopy

local packer = nil
local function init()

  --install packer if it does not exist
  local package_root = join_path(runtime_data_location, 'site', 'pack') 
  local packer_path = join_path(package_root, 'packer', 'opt', 'packer.nvim')
  if fn.empty(fn.glob(packer_path)) > 0 then
    cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. packer_path)
  end

  -- load packer and initialize it
  if packer == nil then
    packer = require('packer')
    packer.init({disable_commands = true, 
                 package_root = package_root, 
                 compile_path = join_path(config_file_location, 'plugin', 'packer_compiled.vim'),
             })
  end

  local use = packer.use
  packer.reset()

  -- Main plugings and its configuration
  -- Packer can manage itself as an optional plugin
  use{'wbthomason/packer.nvim', opt = true}

  -- Base16 colorsheme 
  use{'chriskempson/base16-vim', config = [[require('plugin_config.base16-vim')]]}

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

  -- Fast movement like Easymotion (lua)
  use{'phaazon/hop.nvim', as = 'hop',
        config = "require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }"
    }

  -- Async building & commands
  use {'tpope/vim-dispatch', cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Show tags in sidebar
  use{'preservim/tagbar', config=[[require('plugin_config.tagbar')]]}

  -- Ultisnips
  use{'SirVer/ultisnips', config=[[require('plugin_config.ultisnips')]],
      requires = 'honza/vim-snippets'}

  -- Indentation tracking
  use {'lukas-reineke/indent-blankline.nvim', branch = 'lua',
    setup = [[require('plugin_config.indentline')]]
  }

  -- For fast editing of html and css files
  use{'mattn/emmet-vim', ft={'css','less','sass','scss','html'}}

  -- Restore cursor location and fold
  use{'vim-scripts/restore_view.vim'}

  -- Commenting
  use{'gennaro-tedesco/nvim-commaround'}

  -- Wrapping/delimiters
  use {'machakann/vim-sandwich', {'andymass/vim-matchup', 
        setup = [[require('plugin_config.matchup')]], 
        event = 'BufEnter'}
    }

  -- Turn off Search highlight when not needed
  use 'romainl/vim-cool'

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
  use {'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    setup = [[require('plugin_config.telescope_setup')]],
    config = [[require('plugin_config.telescope')]],
    cmd = 'Telescope'
  }

  use {'nvim-telescope/telescope-frecency.nvim', requires = 'tami5/sql.nvim'}

  -- Undo tree
  use {'mbbill/undotree', cmd = 'UndotreeToggle',
        config = [[require('plugin_config.undotree')]]
  }

  -- Autocorrection 
  use{'jdelkins/vim-correction', ft={'markdown','text','textile', 'git',
                                        'gitcommit', 'plaintex', 'tex', 'latex',
                                        'rst', 'asciidoc', 'textile', 'pandoc'},
      requires='tpope/vim-abolish'}

  -- Git
  use {{'tpope/vim-fugitive', cmd = {'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull'}},
    {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}, 
      config = "require('gitsigns').setup {}",event = 'BufEnter'}, 
    {'TimUntersberger/neogit', opt = true}
  }

  -- Pretty symbols
  use{'kyazdani42/nvim-web-devicons', 
        config=[[require'nvim-web-devicons'.setup {default = true}]]}

  -- Multiple Cursors
  use{'mg979/vim-visual-multi'}

  use{'tpope/vim-repeat'}
  
  -- Terminal
  use 'voldikss/vim-floaterm'

  -- REPLs
  use {'hkupty/iron.nvim', setup = [[vim.g.iron_map_defaults = 0]],
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
    requires = {'nvim-treesitter/nvim-treesitter-refactor', 
                'nvim-treesitter/nvim-treesitter-textobjects'},
    config = [[require('plugin_config.treesitter')]]
  }

  -- Rainbow braket and other matches in source code
  use{'p00f/nvim-ts-rainbow', requires={'nvim-treesitter/nvim-treesitter'}}

  -- Just for tracking progess until this is ready for use
  use {'mfussenegger/nvim-lint', opt = true}

  -- completion and snippets
  use {'hrsh7th/nvim-compe', config = [[require('plugin_config.compe')]], event = 'InsertEnter *'}
  use {'hrsh7th/vim-vsnip', config = [[require('plugin_config.vsnip')]], event = 'InsertEnter *'}
  use {'rafamadriz/friendly-snippets'}

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

  -- better window/pane switching inside tmux
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
