-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Quickfix stuff
vim.keymap.set("n", "<leader>]q", ":cnext<CR>", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "<leader>[q", ":cprev<CR>", { desc = "Previous Quickfix Item" })
vim.keymap.set("n", "<leader>]Q", ":clast<CR>", { desc = "Last Quickfix Item" })
vim.keymap.set("n", "<leader>[Q", ":cfirst<CR>", { desc = "First Quickfix Item" })
vim.keymap.set("n", "<leader>[Q", ":cfirst<CR>", { desc = "First Quickfix Item" })
vim.keymap.set("n", "<leader>xr", ":call setqflist([])<CR>", { desc = "Reset quickfix" })
