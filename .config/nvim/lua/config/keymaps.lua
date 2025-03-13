-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Move in insert mode
map("i", "<c-h>", "<left>", { desc = "Move left in insert mode" })
map("i", "<c-j>", "<down>", { desc = "Move down in insert mode" })
map("i", "<c-k>", "<up>", { desc = "Move up in insert mode" })
map("i", "<c-l>", "<right>", { desc = "Move right in insert mode" })

-- Code dragging in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down 1 line" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up 1 line" })

-- Screen moves
map("n", "J", "<C-d>", { desc = "Move down 1/2 page" })
map("n", "K", "<C-u>", { desc = "Move up 1/2 page" })

-- Easier line start/end
map({ "n", "v", "o" }, "H", "^", { desc = "Line start" })
map({ "n", "v", "o" }, "L", "$", { desc = "Line end" })

-- Easier buffer swiching
map("n", "<tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
