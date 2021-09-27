-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/mayank/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/mayank/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/mayank/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/mayank/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/mayank/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ListToggle = {
    config = { "require('plugin_config.ListToggle')" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/ListToggle"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/cmp-buffer"
  },
  ["cmp-calc"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/cmp-calc"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/cmp-emoji"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/cmp-path"
  },
  ["cmp-tabnine"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/cmp-tabnine"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/cmp_luasnip"
  },
  ["dial.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/dial.nvim"
  },
  ["emmet-vim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/emmet-vim"
  },
  ["formatter.nvim"] = {
    config = { "require('plugin_config.format')" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "require('gitsigns').setup {}" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim"
  },
  hop = {
    config = { "require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/hop"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim"
  },
  ["iron.nvim"] = {
    commands = { "IronRepl", "IronSend", "IronReplHere" },
    config = { "require('plugin_config.iron')" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/iron.nvim"
  },
  ["limelight.vim"] = {
    commands = { "Limelight" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/limelight.vim"
  },
  ["lsp-status.nvim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/lsp-status.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  mesonic = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/mesonic"
  },
  neogit = {
    loaded = false,
    needs_bufread = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/neogit"
  },
  ["neuron.nvim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/neuron.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "require('plugin_config.completion')" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "require('colorizer').setup {'css','less','sass','scss','html','javascript','python','stylus'}" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-dap"
  },
  ["nvim-lint"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-lint"
  },
  ["nvim-lspconfig"] = {
    config = { "require('plugin_config.lsp')" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/nvim-lspinstall"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/nvim-toggleterm.lua"
  },
  ["nvim-tree.lua"] = {
    config = { "require('plugin_config.nvim-tree')" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-ts-rainbow" },
    config = { "require('plugin_config.treesitter')" },
    loaded = false,
    needs_bufread = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
  },
  ["nvim-treesitter-refactor"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/nvim-treesitter-refactor"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects"
  },
  ["nvim-ts-rainbow"] = {
    config = { "require('plugin_config.nvim-ts-rainbow')" },
    load_after = {
      ["nvim-treesitter"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "require'nvim-web-devicons'.setup {default = true}" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons"
  },
  nvim_comment = {
    config = { "require('nvim_comment').setup()" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/nvim_comment"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["restore_view.vim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/restore_view.vim"
  },
  ["shade.nvim"] = {
    config = { "require('plugin_config.shade')" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/shade.nvim"
  },
  ["sql.nvim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/sql.nvim"
  },
  ["surround.nvim"] = {
    config = { 'require"surround".setup {mappings_style = "surround"}' },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/surround.nvim"
  },
  tagbar = {
    config = { "require('plugin_config.tagbar')" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/tagbar"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/targets.vim"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "require('plugin_config.telescope')" },
    loaded = false,
    needs_bufread = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/telescope.nvim"
  },
  undotree = {
    commands = { "UndotreeToggle" },
    config = { "require('plugin_config.undotree')" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/undotree"
  },
  vim = {
    config = { "require('plugin_config.dracula')" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/vim"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-correction"] = {
    after_files = { "/home/mayank/.local/share/nvim/site/pack/packer/opt/vim-correction/after/plugin/correction.vim" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/vim-correction"
  },
  ["vim-dispatch"] = {
    commands = { "Dispatch", "Make", "Focus", "Start" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/vim-dispatch"
  },
  ["vim-easy-align"] = {
    config = { "require('plugin_config.easy_align')" },
    keys = { { "", "<Plug>(EasyAlign)" } },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/vim-easy-align"
  },
  ["vim-enmasse"] = {
    commands = { "EnMasse" },
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/vim-enmasse"
  },
  ["vim-fugitive"] = {
    commands = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
    loaded = false,
    needs_bufread = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/vim-fugitive"
  },
  ["vim-grammarous"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/vim-grammarous"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-signature"] = {
    config = { "require('plugin_config.signature')" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/vim-signature"
  },
  ["vim-startify"] = {
    config = { "require('plugin_config.vim-startify')" },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/vim-startify"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-wordchipper"] = {
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/vim-wordchipper"
  },
  ["vim-wordy"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/vim-wordy"
  },
  vimtex = {
    config = { "require('plugin_config.vimtex')" },
    loaded = false,
    needs_bufread = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/opt/vimtex"
  },
  ["which-key.nvim"] = {
    config = { 'require("plugin_config.which-key")' },
    loaded = true,
    path = "/home/mayank/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^cmp"] = "nvim-cmp",
  ["^nvim%-treesitter"] = "nvim-treesitter",
  ["^nvim%-web%-devicons"] = "nvim-web-devicons",
  ["^plenary"] = "plenary.nvim",
  ["^telescope"] = "telescope.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: indent-blankline.nvim
time([[Setup for indent-blankline.nvim]], true)
require('plugin_config.indentline')
time([[Setup for indent-blankline.nvim]], false)
time([[packadd for indent-blankline.nvim]], true)
vim.cmd [[packadd indent-blankline.nvim]]
time([[packadd for indent-blankline.nvim]], false)
-- Setup for: iron.nvim
time([[Setup for iron.nvim]], true)
vim.g.iron_map_defaults = 0
time([[Setup for iron.nvim]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
require('plugin_config.telescope_setup')
time([[Setup for telescope.nvim]], false)
-- Config for: shade.nvim
time([[Config for shade.nvim]], true)
require('plugin_config.shade')
time([[Config for shade.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
require("plugin_config.which-key")
time([[Config for which-key.nvim]], false)
-- Config for: ListToggle
time([[Config for ListToggle]], true)
require('plugin_config.ListToggle')
time([[Config for ListToggle]], false)
-- Config for: vim-signature
time([[Config for vim-signature]], true)
require('plugin_config.signature')
time([[Config for vim-signature]], false)
-- Config for: vim
time([[Config for vim]], true)
require('plugin_config.dracula')
time([[Config for vim]], false)
-- Config for: vim-startify
time([[Config for vim-startify]], true)
require('plugin_config.vim-startify')
time([[Config for vim-startify]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require('plugin_config.lsp')
time([[Config for nvim-lspconfig]], false)
-- Config for: hop
time([[Config for hop]], true)
require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
time([[Config for hop]], false)
-- Config for: surround.nvim
time([[Config for surround.nvim]], true)
require"surround".setup {mappings_style = "surround"}
time([[Config for surround.nvim]], false)
-- Config for: tagbar
time([[Config for tagbar]], true)
require('plugin_config.tagbar')
time([[Config for tagbar]], false)
-- Config for: nvim_comment
time([[Config for nvim_comment]], true)
require('nvim_comment').setup()
time([[Config for nvim_comment]], false)
-- Config for: formatter.nvim
time([[Config for formatter.nvim]], true)
require('plugin_config.format')
time([[Config for formatter.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require('plugin_config.nvim-tree')
time([[Config for nvim-tree.lua]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Make lua require("packer.load")({'vim-dispatch'}, { cmd = "Make", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Focus lua require("packer.load")({'vim-dispatch'}, { cmd = "Focus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Start lua require("packer.load")({'vim-dispatch'}, { cmd = "Start", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gpush lua require("packer.load")({'vim-fugitive'}, { cmd = "Gpush", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gpull lua require("packer.load")({'vim-fugitive'}, { cmd = "Gpull", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gstatus lua require("packer.load")({'vim-fugitive'}, { cmd = "Gstatus", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Gblame lua require("packer.load")({'vim-fugitive'}, { cmd = "Gblame", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file IronRepl lua require("packer.load")({'iron.nvim'}, { cmd = "IronRepl", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Limelight lua require("packer.load")({'limelight.vim'}, { cmd = "Limelight", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file IronSend lua require("packer.load")({'iron.nvim'}, { cmd = "IronSend", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file IronReplHere lua require("packer.load")({'iron.nvim'}, { cmd = "IronReplHere", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file EnMasse lua require("packer.load")({'vim-enmasse'}, { cmd = "EnMasse", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file UndotreeToggle lua require("packer.load")({'undotree'}, { cmd = "UndotreeToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Dispatch lua require("packer.load")({'vim-dispatch'}, { cmd = "Dispatch", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args> }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> <Plug>(EasyAlign) <cmd>lua require("packer.load")({'vim-easy-align'}, { keys = "<lt>Plug>(EasyAlign)", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType java ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "java" }, _G.packer_plugins)]]
vim.cmd [[au FileType php ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "php" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType puppet ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "puppet" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "rust" }, _G.packer_plugins)]]
vim.cmd [[au FileType twig ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "twig" }, _G.packer_plugins)]]
vim.cmd [[au FileType xml ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "xml" }, _G.packer_plugins)]]
vim.cmd [[au FileType yml ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "yml" }, _G.packer_plugins)]]
vim.cmd [[au FileType perl ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "perl" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType sass ++once lua require("packer.load")({'nvim-colorizer.lua', 'emmet-vim'}, { ft = "sass" }, _G.packer_plugins)]]
vim.cmd [[au FileType scss ++once lua require("packer.load")({'nvim-colorizer.lua', 'emmet-vim'}, { ft = "scss" }, _G.packer_plugins)]]
vim.cmd [[au FileType less ++once lua require("packer.load")({'nvim-colorizer.lua', 'emmet-vim'}, { ft = "less" }, _G.packer_plugins)]]
vim.cmd [[au FileType stylus ++once lua require("packer.load")({'nvim-colorizer.lua'}, { ft = "stylus" }, _G.packer_plugins)]]
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType go ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "go" }, _G.packer_plugins)]]
vim.cmd [[au FileType sql ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "sql" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-dap', 'nvim-ts-rainbow', 'emmet-vim', 'vim-correction', 'vim-wordy', 'nvim-treesitter'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType css ++once lua require("packer.load")({'nvim-colorizer.lua', 'nvim-dap', 'nvim-ts-rainbow', 'emmet-vim', 'nvim-treesitter'}, { ft = "css" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'vim-correction', 'vim-wordy', 'nvim-treesitter'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'vim-correction', 'vim-wordy', 'vimtex', 'nvim-treesitter'}, { ft = "tex" }, _G.packer_plugins)]]
vim.cmd [[au FileType coffee ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "coffee" }, _G.packer_plugins)]]
vim.cmd [[au FileType ruby ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "ruby" }, _G.packer_plugins)]]
vim.cmd [[au FileType matlab ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "matlab" }, _G.packer_plugins)]]
vim.cmd [[au FileType cmake ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "cmake" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-dap', 'nvim-ts-rainbow', 'nvim-treesitter'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType text ++once lua require("packer.load")({'vim-correction', 'vim-wordy'}, { ft = "text" }, _G.packer_plugins)]]
vim.cmd [[au FileType textile ++once lua require("packer.load")({'vim-correction', 'vim-correction', 'vim-wordy', 'vim-wordy'}, { ft = "textile" }, _G.packer_plugins)]]
vim.cmd [[au FileType git ++once lua require("packer.load")({'vim-correction', 'vim-wordy'}, { ft = "git" }, _G.packer_plugins)]]
vim.cmd [[au FileType gitcommit ++once lua require("packer.load")({'vim-correction', 'vim-wordy'}, { ft = "gitcommit" }, _G.packer_plugins)]]
vim.cmd [[au FileType plaintex ++once lua require("packer.load")({'vim-correction', 'vim-wordy'}, { ft = "plaintex" }, _G.packer_plugins)]]
vim.cmd [[au FileType latex ++once lua require("packer.load")({'vim-correction', 'vim-wordy', 'vimtex'}, { ft = "latex" }, _G.packer_plugins)]]
vim.cmd [[au FileType rst ++once lua require("packer.load")({'vim-correction', 'vim-wordy'}, { ft = "rst" }, _G.packer_plugins)]]
vim.cmd [[au FileType asciidoc ++once lua require("packer.load")({'vim-correction', 'vim-wordy'}, { ft = "asciidoc" }, _G.packer_plugins)]]
vim.cmd [[au FileType pandoc ++once lua require("packer.load")({'vim-correction', 'vim-wordy'}, { ft = "pandoc" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'gitsigns.nvim', 'dial.nvim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-autopairs'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/elixir.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/elixir.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/elixir.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/fish.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/fish.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/fish.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdresource.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdresource.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdresource.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gomod.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gomod.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gomod.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/graphql.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/graphql.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/graphql.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hcl.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hcl.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hcl.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/heex.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/heex.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/heex.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/json5.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/json5.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/json5.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/julia.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/julia.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/julia.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ledger.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ledger.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ledger.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/nix.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/nix.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/nix.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ql.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ql.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ql.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/surface.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/surface.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/surface.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/teal.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/teal.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/teal.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/tlaplus.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/tlaplus.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/tlaplus.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/yang.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/yang.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/yang.vim]], false)
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/zig.vim]], true)
vim.cmd [[source /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/zig.vim]]
time([[Sourcing ftdetect script at: /home/mayank/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/zig.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
