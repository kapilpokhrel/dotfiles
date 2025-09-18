local barbar = {
    'romgrk/barbar.nvim',
    dependencies = {
        'lewis6991/gitsigns.nvim',     -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        animation = true,
        auto_hide = 1,
        focus_on_close = 'previous',
        highlight_alternate = true
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
}

local tabby = {
    'nanozuki/tabby.nvim',
    ---@type TabbyConfig
    opts = {
        -- configs...
    },
}
return tabby
