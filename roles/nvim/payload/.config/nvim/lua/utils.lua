local api, keymap, cmd, fn = vim.api, vim.keymap, vim.cmd, vim.fn
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local programming_filetypes = {'c', 'cpp', 'cs', 'java', 'python', 'go', 'php',
                               'fortran', 'javascript', 'typescript', 'json',
                               'lisp', 'sh', 'csh', 'dockerfile', 'pascal',
                               'haskell', 'julia', 'r', 'rust', 'twig', 'xml',
                               'vim', 'perl', 'sql', 'html', 'css', 'sass',
                               'scss', 'less', 'scala', 'scheme', 'swift',
                               'clojure', 'markdown', 'tex', 'ruby', 'matlab',
                               'lua', 'make', 'cmake', 'yaml', 'toml',}

local text_filetypes = {'markdown','text', 'textile', 'git', 'gitcommit',
                        'plaintex', 'tex', 'rst', 'asciidoc', 'html',}

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
    -- keymap_table is inform of keys and action pairs.
    --  action is either vim command (as string) or callback (lua function).
    options = options or {noremap = true, silent = true}
    if type(mode) == 'string' then
        local m = mode:lower():sub(1,1)
        for key, action in pairs(keymap_table) do
            keymap.set(m, key, action, options)
        end
    elseif type(mode) == 'table' then
        for _, cur_mode in ipairs(mode) do
            set_keymap(cur_mode, keymap_table, options)
        end
    else
        error("Unsupported mode.")
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
  local leader_key_table = {}
  for k, v in pairs(key_table) do
    leader_key_table['<leader>' .. k] = v
  end
  return leader_key_table
end

-- autocmd function
local function set_augroup(definitions)
    --[[ definition is a table in form of
    -- local definition = {augroup_name={
    --                            {event=string_or_table, option={
    --                            pattern1=action1, pattern2=action2}}
    --                            }
    --                    }
    --  action is either vim command (as string) or callback (lua function).
    --]]
  for group_name, autocmds in pairs(definitions) do
    local gid = api.nvim_create_augroup(group_name, {clear = true})
    for _, aucmd in ipairs(autocmds) do
      local event = aucmd['event']
      for pattern, action in pairs(aucmd['option']) do
        local opts
        if type(action) == "string" then
          opts = {group=gid, pattern=pattern, command=action}
        else
          opts = {group=gid, pattern=pattern, callback=action}
        end
        api.nvim_create_autocmd(event, opts)
      end
    end
  end
end

-- set commands
local function set_command(command_table, options)
    -- command_table is in form of name, action pairs.
    --  action is either vim command (as string) or callback (lua function).
    options = options or {}
    for name, action in pairs(command_table) do
        api.nvim_create_user_command(name, action, options)
    end
end

-- a generic deepcopy function
local function deepcopy(orig)
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


-- check if a module is available or not
-- this function has an advantage over pcall(require, module_name) as it
-- do not import the module.
function is_module_available(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.searchers or package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end


return {fn=fn,
		cmd = cmd,
	    has = has,
        programming_filetypes = programming_filetypes,
        text_filetypes = text_filetypes,
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
        set_augroup = set_augroup,
        set_command = set_command,
        deepcopy = deepcopy,
        is_module_available = is_module_available,
    }
