local utils = require('utils')
local fn, cmd = utils.fn, utils.cmd
local join_path = utils.join_path
local programming_filetypes = utils.programming_filetypes
local text_filetypes = utils.text_filetypes
local set_augroup = utils.set_augroup
local set_command = utils.set_command

-- install packer if it does not exist
local plugins_root = join_path(fn.stdpath('data'), 'site', 'pack')
local packer_path = join_path(plugins_root, 'packer', 'start', 'packer.nvim')
if fn.empty(fn.glob(packer_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        packer_path })
    cmd [[packadd packer.nvim]]
end

local packer
local function init()
    -- load packer and initialize it
    if packer == nil then
        packer = require('packer')
        packer.init({ disable_commands = true,
            package_root = plugins_root,
            depth = 1,
            clone_timeout = 600,
            luarocks = {
                python_cmd = '/usr/bin/python3' -- Set the python command to use for running hererocks
            },
        })
    end

    local use = packer.use
    packer.reset()

    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' } -- package manager itself

    -- ============================================================================
    -- Other Plugins and their configuration

    -------------------------------------------------------------------------------
    -- UI look and functionality
    -------------------------------------------------------------------------------
    -- Pretty symbols
    use { 'kyazdani42/nvim-web-devicons', module = "nvim-web-devicons",
            setup = [[require'nvim-web-devicons'.setup {default = true}]]
    }
    use { { 'dracula/vim', config = [[vim.cmd('colorscheme dracula')]] },       -- dracula theme
        { 'hoob3rt/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons',    -- status bar
            config = [[require('plugin_conf.lualine').config()]],
            event = "BufWinEnter", opt=true, },
        { 'mhinz/vim-startify',                                                 -- Start Page
            config = [[require('plugin_conf.vim-startify').config()]] },
        { 'TaDaa/vimade', event="BufWinEnter"},                                 -- shade the inactive window
        { 'vim-scripts/restore_view.vim', event="BufWinEnter" },                -- Restore cursor location and fold
        { 'junegunn/limelight.vim', cmd = 'Limelight' },                        -- Put the text under cursor in focus: good for presenting
        { 'kshenoy/vim-signature', event="BufWinEnter" },                       -- Show user-set marks in the file in signcolumn
        { 'junegunn/fzf', run = { ":call fzf#install()", "./install --all" } }, -- latest version of fzf support
        { 'tpope/vim-repeat' },                                                 -- Repeat (.) behavior for multiple plugins
        { "akinsho/toggleterm.nvim",                                            -- Easy terminal toggling
            config = [[require('plugin_conf.toggleterm').config()]],
            event='BufWinEnter',
        },
        { 'phaazon/hop.nvim', config = "require('hop').setup()",                -- Fast movement like Easymotion (in lua)
            event = 'BufWinEnter', },
        { "folke/which-key.nvim",                                               -- Shows different keymapping depending on input
            config = "require('plugin_conf.which-key').config()" },
        { 'Valloric/ListToggle',                                                -- Toggle of quickfix and the location list
            config = "require('plugin_conf.ListToggle').config()" },
    }
    -- Indentation tracking
    use { 'lukas-reineke/indent-blankline.nvim',
        setup = [[require('plugin_conf.indentline').setup()]],
        config = [[require('plugin_conf.indentline').config()]],
        event = 'BufEnter' }
    -- Directory tree at the side
    use { 'kyazdani42/nvim-tree.lua',
        requires = { "kyazdani42/nvim-web-devicons" },                          -- for file icon
        after="nvim-web-devicons",
        cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
        setup = "require('plugin_conf.nvim-tree').setup()",
        config = "require('plugin_conf.nvim-tree').config()",
    }
    -------------------------------------------------------------------------------


    -------------------------------------------------------------------------------
    -- Plugins for editing
    -------------------------------------------------------------------------------
    use { { 'monaqa/dial.nvim', event = 'BufRead',                              -- Context sensitive increment and decrement
        config = [[require('plugin_conf.dial').config()]] },
        { 'Olical/vim-enmasse', cmd = 'EnMasse' },                              -- Edit directly from Quickfix list
        { 'rhysd/vim-grammarous' },                                             -- Grammar checking
        { 'mbbill/undotree', event = "BufWinEnter",                             -- Undo tree
            config = [[require('plugin_conf.undotree').config()]] },
        { 'mattn/emmet-vim',                                                    -- For fast editing of html and css files
            ft = { 'css', 'less', 'sass', 'scss', 'html' } },
        { "terrortylor/nvim-comment",                                           -- Commenting
            ft = programming_filetypes,
            config = "require('nvim_comment').setup()" },
        { 'jdelkins/vim-correction', ft = text_filetypes,                       -- Autocorrection
            requires = {{'tpope/vim-abolish', module='vim-abolish'}} },
        --{"blackCauldron7/surround.nvim",                                      -- Wrapping/delimiters
        --  config = [[require"surround".setup {mappings_style = "surround"}]]},
        { 'windwp/nvim-autopairs', event = 'InsertEnter', opt = true,           -- autopair brackets
            config = [[require('nvim-autopairs').setup { }]] },
        { 'wellle/targets.vim', event = 'BufWinEnter' },                        -- Text objects
        { 'preservim/vim-wordy', ft = text_filetypes },                         -- Uncover usage problems in your writing
        { 'glacambre/firenvim', run = ":call firenvim#install(0)" },            -- open neovim inside textarea in browsers
    }
    -------------------------------------------------------------------------------


    -------------------------------------------------------------------------------
    -- Plugins for formatting
    -------------------------------------------------------------------------------
    use { { 'junegunn/vim-easy-align', event = 'BufEnter' },                    -- Align a character
        { 'mhartington/formatter.nvim', ft=programming_filetypes,               -- format source code
            config = [[require('plugin_conf.formatter').config()]], }
    }
    -------------------------------------------------------------------------------


    -------------------------------------------------------------------------------
    -- Plugins for IDE functionality
    -------------------------------------------------------------------------------
    -- Async building & commands
    use { 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
            ft=programming_filetypes,}
    -- Show tags in sidebar
    use { 'preservim/tagbar', event="BufWinEnter", ft=programming_filetypes,
        config = [[require('plugin_conf.tagbar').config()]] }                   -- TODO: Is this plugin even needed given LSP support?
    -- REPLs
    use { 'hkupty/iron.nvim', setup = [[vim.g.iron_map_defaults = 0]],
        config = [[require('plugin_conf.iron').config()]],
        cmd = { 'IronRepl', 'IronSend', 'IronReplHere' },                       -- TODO: Is this plugin required given ToggleTerm?
    }
    -- Source code highlighting
    use {{
            'nvim-treesitter/nvim-treesitter',
            config = [[require('plugin_conf.treesitter').config()]],
            run = ':TSUpdate',
            ft = programming_filetypes,
            module='nvim-treesitter'
        },
        {
            'lewis6991/spellsitter.nvim',
            after = 'nvim-treesitter',
            config = function()
              require('spellsitter').setup()
            end,
            ft = programming_filetypes,
        },
    }


    -- Linter Suppot
    --use {'mfussenegger/nvim-lint', ft = programming_filetypes}                -- TODO: add autocmds. Is this plugin needed given LSP?

    -- popup windows for searching
    use { 'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/popup.nvim', module='popup' },
            { 'nvim-lua/plenary.nvim' },                                        -- lua functions used by other plugins
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
            { 'nvim-telescope/telescope-frecency.nvim',                         -- sort filenames by access frequency
                requires = { 'tami5/sql.nvim', module='sql.nvim' }},
        },
        setup = [[require('plugin_conf.telescope').setup()]],
        config = [[require('plugin_conf.telescope').config()]],
        cmd = 'Telescope',
        module='telescope',
    }

    -- -- completion and snippets: coq
    -- use { "ms-jpq/coq_nvim", branch = 'coq',
    --     requires = { { "ms-jpq/coq.artifacts", branch = 'artifacts' },
    --         { "ms-jpq/coq.thirdparty", branch = '3p' } },
    --     run = ":COQdeps",
    --     setup = "require('plugin_conf.completion').setup()",
    --     config = "require('plugin_conf.completion').config()",
    -- }

    -- completion and snippets: nvim-cmp (preferred one)
    use {'L3MON4D3/LuaSnip',                                                    -- Snippets plugin (LuaSnip)
            requires={'rafamadriz/friendly-snippets'},                          -- Collection of snippets for LuaSnip
        module = 'luasnip',
        event = 'BufWinEnter'
    }
    use { 'hrsh7th/nvim-cmp',                                                   -- Autocompletion plugin
        setup = "require('plugin_conf.completion').setup()",
        config = "require('plugin_conf.completion').config()",
        module = 'cmp',
        event = 'BufWinEnter'
    }

    use{'hrsh7th/cmp-nvim-lsp',                                                 -- nvim-cmp source: LSP
        requires='hrsh7th/nvim-cmp'}
    use{'hrsh7th/cmp-cmdline', requires='hrsh7th/nvim-cmp'}                     -- nvim-cmp source: vim commands
    use{'hrsh7th/cmp-calc', requires='hrsh7th/nvim-cmp'}                        -- nvim-cmp source: calc
    use{'hrsh7th/cmp-nvim-lua',                                                 -- nvim-cmp source: nvim lua API
        requires='hrsh7th/nvim-cmp'}
    use{'hrsh7th/cmp-emoji',                                                    -- nvim-cmp source: emoji
        requires='hrsh7th/nvim-cmp',}
    use{'hrsh7th/cmp-buffer', requires='hrsh7th/nvim-cmp'}                      -- nvim-cmp source: buffer
    use{'hrsh7th/cmp-path', requires='hrsh7th/nvim-cmp'}                        -- nvim-cmp source: path
    use {'tzachar/cmp-tabnine', run='./install.sh',                             -- nvim-cmp source: tabnine
        requires = 'hrsh7th/nvim-cmp'}
    use{'f3fora/cmp-spell', requires='hrsh7th/nvim-cmp'}                        -- nvim-cmp source: vim's spellsuggest
    use{'petertriho/cmp-git',                                                   -- nvim-cmp source: git
            requires = {'hrsh7th/nvim-cmp', "nvim-lua/plenary.nvim"},
        config="require('cmp_git').setup()"}
    use{'saadparwaiz1/cmp_luasnip',                                             -- nvim-cmp source: LuaSnip
            requires={'hrsh7th/nvim-cmp', 'L3MON4D3/LuaSnip'},
    }

    -- LSP and linting support
    use {
        {"williamboman/mason.nvim"},
        {"williamboman/mason-lspconfig.nvim"},
        {"neovim/nvim-lspconfig",
            requires = { 'onsails/lspkind.nvim',
                --'nvim-lua/lsp-status.nvim',                          -- helps in getting info from LSP for statusbar
                {'ray-x/lsp_signature.nvim', module='lsp_signature'},   -- Shows function signature when you type from LSP
            },
            config = [[require('plugin_conf.lsp').config()]],
        }
    }

    -- Debugger
    use { 'mfussenegger/nvim-dap', opt = true, ft = programming_filetypes }
    use { 'puremourning/vimspector',
        setup = [[vim.g.vimspector_enable_mappings = 'HUMAN']],
        disable = true,
        ft = programming_filetypes,
    }
    -- LaTeX
    use { 'lervag/vimtex', ft = { 'tex', 'latex' },
        config = [[require('plugin_conf.vimtex').config()]]
    }
    -- Meson Support
    use { 'igankevich/mesonic', opt=true }
    -------------------------------------------------------------------------------


    -------------------------------------------------------------------------------
    -- Plugins with utility value
    -------------------------------------------------------------------------------
    -- Note taking system based on neuron Zettelkasten concept
    use { "oberblastmeister/neuron.nvim",
        requires = { {'nvim-lua/plenary.nvim'},
            {'nvim-lua/popup.nvim', module="popup"},
            {'nvim-telescope/telescope.nvim'},
        },
        event='BufEnter',
    }
    -- Git support
    use { { 'tpope/vim-fugitive', cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' } },
        { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
            config = "require('gitsigns').setup {}", event = 'BufEnter' },
        { 'TimUntersberger/neogit', opt = true },
    }
    -- Highlight colors for hexadecimal color code
    use { 'norcalli/nvim-colorizer.lua',
        ft = { 'css', 'less', 'sass', 'scss', 'html', 'javascript', 'python', 'stylus' },
        config = [[require('colorizer').setup {'css','less','sass','scss','html','javascript','python','stylus'}]]
    }
    -- Easier moving in tabs and windows with '<c-h/j/k/l>' is supported by
    -- vim-tmux-navigator plugin.
    use { 'christoomey/vim-tmux-navigator', event="BufEnter" }
    -------------------------------------------------------------------------------

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end

-- Command for package management
set_command({ PackerInstall = "packadd packer.nvim | lua require('plugins').install()",
    PackerUpdate = "packadd packer.nvim | lua require('plugins').update()",
    PackerSync = "packadd packer.nvim | lua require('plugins').sync()",
    PackerClean = "packadd packer.nvim | lua require('plugins').clean()",
    PackerCompile = "packadd packer.nvim | lua require('plugins').compile()", },
    { bang = true })

-- run PackerCompile automatically when this file changes
set_augroup({
    packer_user_aucmd = {
        {event= "BufWritePost",
            option = { ["plugins.lua"] = "source <afile> | PackerCompile" },},
    },})

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
