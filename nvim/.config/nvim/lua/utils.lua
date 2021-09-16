local api, cmd, fn = vim.api, vim.cmd, vim.fn
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function has(feature)
    return (fn.has(feature) == 1)
end

-- path management functions
local function get_path_separator()
  if has('win64') or has('win32') then return '\\' end
  return '/'
end

local function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*" .. get_path_separator() .. ")")
end

local function get_parent_dir(path)
    local separator = get_path_separator()
    local pattern = "^(.+)" .. separator
    -- if path has separator at end, remove it
    path = path:gsub(separator .. '*$', '')
    local parent_dir = path:match(pattern) .. separator
    return parent_dir
end

local function join_path(...)
  local separator = get_path_separator()
  return table.concat({...}, separator)
end

-- key mapping functions
local function set_keymap(mode, keymap_table, options)
    options = options or {noremap = true, silent = true}
    m = mode:lower():sub(1,1)
    for key, val in pairs(keymap_table) do
        api.nvim_set_keymap(m, key, val, options)
    end
end

local function normal_mode_set_keymap(keymap_table, options)
    set_keymap('normal', keymap_table, options)
end

local function visual_mode_set_keymap(keymap_table, options)
    set_keymap('x', keymap_table, options)
end

local function visualselect_mode_set_keymap(keymap_table, options)
    set_keymap('visual', keymap_table, options)
end

local function select_mode_set_keymap(keymap_table, options)
    set_keymap('select', keymap_table, options)
end

local function insert_mode_set_keymap(keymap_table, options)
    set_keymap('insert', keymap_table, options)
end

local function commandline_mode_set_keymap(keymap_table, options)
    set_keymap('command', keymap_table, options)
end

local function terminal_mode_set_keymap(keymap_table, options)
    set_keymap('terminal', keymap_table, options)
end

local function leader_keymap_table(key_table)
  leader_key_table = {}
  for k, v in pairs(key_table) do
    leader_key_table['<leader>' .. k] = v
  end
  return leader_key_table
end

-- autocmd function
function create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    cmd('augroup ' .. group_name)
    cmd('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      cmd(command)
    end
    cmd('augroup END')
  end
end

-- a generic deepcopy function
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


return {api = api,
        cmd = cmd,
        fn = fn,
        has = has,
        get_path_separator = get_path_separator,
        script_path = script_path,
        get_parent_dir = get_parent_dir,
        join_path = join_path,
        set_keymap = set_keymap,
        normal_mode_set_keymap = normal_mode_set_keymap,
        visual_mode_set_keymap = visual_mode_set_keymap,
        visualselect_mode_set_keymap = visualselect_mode_set_keymap,
        select_mode_set_keymap = select_mode_set_keymap,
        insert_mode_set_keymap = insert_mode_set_keymap,
        commandline_mode_set_keymap = commandline_mode_set_keymap,
        terminal_mode_set_keymap = terminal_mode_set_keymap,
        leader_keymap_table = leader_keymap_table,
        create_augroups = create_augroups,
        deepcopy = deepcopy,
    }
