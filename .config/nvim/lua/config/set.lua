-- Disabling netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showtabline = 1
vim.opt.cmdheight = 0

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.incsearch = true

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Thicker vertical & horizontal splits
vim.opt.fillchars:append({
  vert = "┃",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
})

vim.o.hlsearch = true
vim.o.mouse = "a"  -- enable mouse for scrolling

-- Highlight vertical and horizontal split lines
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#cccccc", bg = "NONE" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#cccccc", bg = "NONE" })

-- Create an augroup to manage search highlight behavior
vim.api.nvim_create_augroup("clear_search_highlight_on_insert", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
  group = "clear_search_highlight_on_insert",
  desc = "Clear hlsearch on entering insert mode",
  callback = function()
    -- Clear the highlight only if it's currently active.
    if vim.v.hlsearch == 1 then
      vim.schedule(function()
        vim.cmd.nohlsearch()
      end)
    end
  end
})

