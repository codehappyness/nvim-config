-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
--vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
vim.keymap.set(
  "v",
  "<leader>r",
  ":<C-u>MoltenEvaluateVisual<CR>gv",
  { silent = true, desc = "evaluate visual selection" }
)
vim.keymap.set("n", "<leader>rd", ":MoltenDelete<CR>",
    { silent = true, desc = "molten delete cell" })
vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>",
    { silent = true, desc = "hide output" })
vim.keymap.set("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>",
    { silent = true, desc = "show/enter output" })
