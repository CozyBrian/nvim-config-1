-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>mn", "<cmd>TestNearest<cr>", { desc = "Test Nearest" })
vim.keymap.set("n", "<leader>mf", "<cmd>TestFile<cr>", { desc = "Test File" })
vim.keymap.set("n", "<leader>ms", "<cmd>TestSuite<cr>", { desc = "Test Suite" })
