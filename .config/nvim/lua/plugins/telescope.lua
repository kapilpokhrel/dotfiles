return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
        vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>tc', builtin.commands, {})
        vim.keymap.set('n', '<leader>tr', builtin.registers, {})
        vim.keymap.set('n', '<leader>td', builtin.diagnostics, {})
        vim.keymap.set('n', '<leader>to', builtin.treesitter, {})
        vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
    end
}
