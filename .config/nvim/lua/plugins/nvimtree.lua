return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require('nvim-tree').setup({
            hijack_netrw = false,
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
        })
    end,
}
