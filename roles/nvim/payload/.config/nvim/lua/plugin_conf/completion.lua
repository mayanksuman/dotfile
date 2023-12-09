-- completion.lua: setup and configure either 'hrsh7th/nvim-cmp + L3MON4D3/LuaSnip'
-- or 'ms-jpq/coq_nvim + ms-jpq/coq.artifacts' depending upon the availability.
-- If both are present then this module prefers 'hrsh7th/nvim-cmp + L3MON4D3/LuaSnip'.
-- Additionally, this module also provides a function to add selected
-- completion capability to language server. This function will be used by
-- 'lsp.lua' to add auto completion to language servers.

local utils = require('utils')
local is_module_available = utils.is_module_available

local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
}


local function setup()
    if is_module_available('cmp') then
        -- no setup needed for 'hrsh7th/nvim-cmp'
    else
        -- setup for 'ms-jpq/coq_nvim'
        vim.g.coq_settings = { auto_start = 'shut-up' }
    end
end


local function cmp_config()
    -- load luasnip
    local luasnip = require 'luasnip'
    require("luasnip.loaders.from_vscode").lazy_load()                          -- load vscode snippet from rafamadriz/friendly-snippets

    -- nvim-cmp setup
    local cmp = require 'cmp'
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },

        mapping = cmp.mapping.preset.insert({
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<Esc>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }),

        completion = {
            completeopt = 'menu,menuone,longest,noinsert,noselect',
        },

        formatting = {
            format = function(entry, vim_item)
                -- fancy icons and a name of kind: use lspkind if present
                local prsnt, lspkind = pcall(require, "lspkind")
                if prsnt then
                    vim_item.kind = string.format('%s %s', lspkind.presets.default[vim_item.kind], vim_item.kind)
                else
                    vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                end

                if entry.source.name == 'cmdline' then
                    vim_item.kind = ""
                end

                -- set a name for each source
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snips]",
                    cmp_tabnine = "[TabNine]",
                    nvim_lua = "[Lua]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                    latex_symbols = "[Latex]",
                    spell = "[Spell]",
                    calc = "[Calc]",
                    emoji = "[Emoji]",
                    cmdline= '[CMD]',
                })[entry.source.name]

                return vim_item
            end,
        },

        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip', keyword_length = 3 },
            { name = "cmp_tabnine", keyword_length = 5 },
            { name = "nvim_lua", keyword_length = 3 },
            { name = 'buffer', keyword_length = 3 },
            { name = 'spell', keyword_length = 3 },
            { name = 'path', keyword_length = 3},
            { name = "calc" },
            { name = "emoji" },
        },
    })


    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'git' },
        }, {
                { name = 'buffer' },
            })
    })

    local cmdline_mapping = cmp.mapping.preset.cmdline({
        ['<Esc>'] = {
            c = function()
                if cmp.visible() then
                    cmp.close()
                end
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, true, true), 'n', true)
            end,}
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmdline_mapping,
        sources = {{ name = 'buffer' }}
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmdline_mapping,
        sources = cmp.config.sources({{ name = 'path' }},
            {{ name = 'cmdline' }})
    })
end

local function config()
    if is_module_available('cmp') then
        cmp_config()
    elseif is_module_available('coq') then
        -- no configuration required for ms-jpq/coq_nvim
    end
end

local function update_lsp_capabilities(capabilities)
    if is_module_available('cmp') then
        if is_module_available('cmp_nvim_lsp') then
            return require('cmp_nvim_lsp').default_capabilities(capabilities)
        end
    elseif is_module_available('coq') then
        return require('coq').lsp_ensure_capabilities(capabilities)
    end
    return capabilities
end

return {config=config, setup=setup, update_lsp_capabilities=update_lsp_capabilities}
