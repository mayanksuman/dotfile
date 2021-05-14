local api, cmd, fn = vim.api, vim.cmd, vim.fn
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function has(feature)
	return (fn.has(feature) == 1)
end

local function get_path_separator()
  if has('win64') or has('win32') then return '\\' end
  return '/'
end

local function join_path(...)
  local separator = get_path_separator()
  return table.concat({...}, separator)
end

local function set_nvim_variable(var_name, value)
    mode = var_name:sub(1,1)
    var_n = var_name:sub(3)
    if mode == 'g' then
        api.nvim_set_var(var_n, value)
    elseif mode =='b' then
        api.nvim_buf_set_var(0, var_n, value)
    elseif mode =='w' then
        api.nvim_win_set_var(0, var_n, value)
    elseif mode =='t' then
        api.nvim_tabpage_set_var(0, var_n, value)
    elseif mode =='v' then
        api.nvim_set_vvar(var_n, value)
    end
end

local function set_option(scope, key, value, add)
  add = add or false
  if add then
    if type(scopes[scope][key]) == 'string' then
      scopes[scope][key] = scopes[scope][key] .. value
      if scope ~= 'o' then scopes['o'][key] = scopes['o'][key] .. value end
    elseif type(scopes[scope][key]) == 'number' then
      scopes[scope][key] = scopes[scope][key] + value
      if scope ~= 'o' then scopes['o'][key] = scopes['o'][key] + value end
    end
  else
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
  end
end

local function get_option(scope, key)
    return scopes[scope][key]
end

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
	set_keymap('visual', keymap_table, options)
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

return {api = api, 
        cmd = cmd, 
        fn = fn,
        has = has,
        join_path = join_path,
        set_nvim_variable = set_nvim_variable,
        set_option = set_option,
        get_option = get_option,
        set_keymap = set_keymap,
        normal_mode_set_keymap = normal_mode_set_keymap,
        visual_mode_set_keymap = visual_mode_set_keymap,
        insert_mode_set_keymap = insert_mode_set_keymap,
        commandline_mode_set_keymap = commandline_mode_set_keymap,
        terminal_mode_set_keymap = terminal_mode_set_keymap,
        leader_keymap_table = leader_keymap_table,
        create_augroups = create_augroups,
    }
