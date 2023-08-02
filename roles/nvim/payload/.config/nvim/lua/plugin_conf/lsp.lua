local mason = require("mason")
local mason_lsp_config = require("mason-lspconfig")
local lspconfig = require('lspconfig')
local lsp_signature = require("lsp_signature")
local lsp, cmd = vim.lsp, vim.cmd


local function config_mason_lsp()
    -- mason should be setup before any server configuration
    mason.setup()
    mason_lsp_config.setup({
        automatic_installation = true, -- automatically install server (based on which servers are set up via lspconfig)
    })
end


local function config_diagnostic()
    -- Do not show diganostic message at the end of line
    local sign_define = vim.fn.sign_define
    sign_define('LspDiagnosticsSignError', {text = '', numhl = 'RedSign'})
    sign_define('LspDiagnosticsSignWarning', {text = '', numhl = 'YellowSign'})
    sign_define('LspDiagnosticsSignInformation', {text = '', numhl = 'WhiteSign'})
    sign_define('LspDiagnosticsSignHint', {text = '', numhl = 'BlueSign'})
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
      signs = true,
      update_in_insert = true,
      underline = true
    })

    -- normal mode diagnostic shortcuts
    local opts = { noremap=true, silent=true }
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)
end


local function on_attach(client, bufnr)
  lsp_signature.on_attach({floating_window_above_cur_line = true})

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
end


local function config_lspconfig()
    local completion_status, completion = pcall(require, "plugin_conf.completion")
    local lsp_flags = {
      -- This is the default in Nvim 0.7+
      debounce_text_changes = 150,
    }

    -- servers to be setup
    local servers = {'angularls', 'ansiblels', 'awk_ls', 'bashls', 'clangd',
        'cssls', 'dockerls', 'eslint', 'html', 'grammarly',
        'jdtls', 'jsonls', 'marksman', 'opencl_ls',
        'perlls', 'phan', 'pyright', 'quick_lint_js',
        'ruby_ls', 'rust_analyzer', 'sorbet', 'lua_ls',
        'tailwindcss', 'texlab', 'tsserver', 'typeprof', 'vimls',
        'yamlls'}

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities['on_attach'] = on_attach
    capabilities['flags'] = capabilities['flags'] or lsp_flags
    if completion_status then
        capabilities = completion.update_lsp_capabilities(capabilities)
    end
    for _, server in ipairs(servers) do
        lspconfig[server].setup(capabilities)
    end
end


local function config()
    config_mason_lsp()
    config_diagnostic()
    config_lspconfig()
end

return {config = config}
