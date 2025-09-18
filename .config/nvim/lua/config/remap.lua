vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ee", vim.cmd.NvimTreeToggle)
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

local modes = { "v", "i" }

-- Disable other mouse clicks
local buttons = {
  "<LeftMouse>", "<2-LeftMouse>", "<3-LeftMouse>", "<4-LeftMouse>", "<5-LeftMouse>",
  "<RightMouse>", "<2-RightMouse>", "<3-RightMouse>", "<4-RightMouse>", "<5-RightMouse>",
  "<MiddleMouse>", "<2-MiddleMouse>", "<3-MiddleMouse>", "<4-MiddleMouse>", "<5-MiddleMouse>",
}
for _, mode in ipairs(modes) do
  for _, btn in ipairs(buttons) do
    vim.keymap.set(mode, btn, function() end, { noremap = true, silent = true })
  end
end

-- Disable scroll
-- Drag can sometimes be useful in visual mode
local scroll_events = {
    "<ScrollWheelUp>",
    "<ScrollWheelDown>",
    "<ScrollWheelLeft>",
    "<ScrollWheelRight>",
}
for _, mode in ipairs(modes) do
  for _, btn in ipairs(scroll_events) do
    vim.keymap.set(mode, btn, function() end, { noremap = true, silent = true })
  end
end
