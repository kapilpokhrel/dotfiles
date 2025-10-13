return {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("diffview").setup({})
        vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Open Git Diff" })
        vim.keymap.set("n", "<leader>gD", "<cmd>DiffviewClose<CR>", { desc = "Close Git Diff" })
    end,
}
