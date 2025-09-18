return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            options = {
                theme = 'auto', -- or 'gruvbox', 'tokyonight', etc.
                section_separators = '',
                component_separators = '',
                globalstatus = true, -- enables a single statusline like VSCode
            },

            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { { 'filename', path = 2 } },
                lualine_x = { 'diagnostics', 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress', { 'searchcount', maxcount = 999 } },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {}
        }
    end,
}
