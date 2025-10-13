-- Autocompletion
return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        { 'hrsh7th/cmp-buffer' },
        { 'FelipeLema/cmp-async-path' },
        { 'hrsh7th/cmp-nvim-lsp-signature-help' },
        { 'onsails/lspkind.nvim' },
        { 'hrsh7th/cmp-calc' },
        { 'L3MON4D3/LuaSnip' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'rafamadriz/friendly-snippets' },
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()     -- load friendly-snippets
        local cmp = require('cmp')
        local luasnip = require("luasnip")
        cmp.setup({
            window = {
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 0,
                },
                documentation = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 0,
                },
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = require("lspkind").cmp_format({
                        mode = "symbol_text", maxwidth = 50, ellipsis_char = '...'
                    })(
                        entry,
                        vim_item
                    )
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"
                    return kind
                end,
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'buffer' },
                { name = 'async_path' },
                { name = 'nvim_lsp_signature_help' },
                { name = 'calc' },
                { name = 'luasnip' },
            },
            preselect = 'item',
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-y"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            experimental = {
                ghost_text = true,
            }
        })


        cmp.setup({
            mapping = cmp.mapping.preset.insert({
            }),
        })
    end
}
