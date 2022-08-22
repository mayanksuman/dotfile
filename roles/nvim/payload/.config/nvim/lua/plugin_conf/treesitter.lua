local function config()
    local ts_configs = require('nvim-treesitter.configs')
    ts_configs.setup {
      ensure_installed = {
        'bash', 'bibtex', 'c', 'c_sharp', 'clojure', 'comment', 'cpp', 'go',
        'haskell', 'make', 'markdown', 'dockerfile', 'python', 'html', 'php',
        'css', 'javascript', 'json', 'jsonc', 'julia', 'kotlin', 'latex', 'lua',
        'ocaml', 'regex', 'r', 'ruby', 'rust', 'toml', 'typescript', 'yaml',
      },
      highlight = {enable = true, use_languagetree = true},
      indent = {enable = true},
      rainbow = {
        enable = true,
        extended_mode = true, -- do not highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = 'gnn',
          node_incremental = 'grn',
          scope_incremental = 'grc',
          node_decremental = 'grm'
        }
      },
      refactor = {
        smart_rename = {enable = true, keymaps = {smart_rename = "grr"}},
        highlight_definitions = {enable = true},
        highlight_current_scope = { enable = true }
      },
    }
end

return {config=config}
