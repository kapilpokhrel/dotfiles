return {
    "hedyhli/outline.nvim",
    config = function()
        -- Example mapping to toggle outline
        vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
            { desc = "Toggle Outline" })

        require("outline").setup {
            outline_window = {
                auto_close = false,
            },
            outline_items = {
            },
            symbol_folding = {
                autofold_depth = 1,
                auto_unfold = {
                    hovered = true,
                },
            },
        }
    end,
}
