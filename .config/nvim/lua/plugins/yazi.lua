return {
    "mikavilpas/yazi.nvim",
    version = "v11.10.2", -- Why not '*' ? -> Because of this issue,  https://github.com/mikavilpas/yazi.nvim/issues/1150
    event = "VeryLazy",
    dependencies = {
        { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
        {
            "<leader>-",
            mode = { "n", "v" },
            "<cmd>Yazi<cr>",
            desc = "Open yazi at the current file",
        },
        {
            "<c-up>",
            "<cmd>Yazi toggle<cr>",
            desc = "Resume the last yazi session",
        },
    },
    opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = true,
        floating_window_scaling_factor = 0.8,
        keymaps = {
            show_help = "<f1>",
        },
        set_keymappings_function = function(yazi_buffer_id, config, context)
            vim.keymap.set("t", ":", function()
                vim.api.nvim_win_close(0, true) -- close current (yazi) window
                vim.api.nvim_feedkeys(":", "n", false)
            end, { buffer = yazi_buffer_id, noremap = true, silent = true })
        end,
    },
    init = function()
        -- mark netrw as loaded so it's not loaded at all.
        --
        -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
        vim.g.loaded_netrwPlugin = 1
    end,
}
