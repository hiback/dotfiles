-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Move in insert mode
map("i", "<c-h>", "<left>", { desc = "Move left in insert mode" })
map("i", "<c-j>", "<down>", { desc = "Move down in insert mode" })
map("i", "<c-k>", "<up>", { desc = "Move up in insert mode" })
map("i", "<c-l>", "<right>", { desc = "Move right in insert mode" })

-- Swap paste behavior in visual mode
map("v", "p", "P", { desc = "Paste without replacing clipboard" })
map("v", "P", "p", { desc = "Paste and replace clipboard (classic)" })

-- Code dragging in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down 1 line" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up 1 line" })
