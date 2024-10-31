vim.g.mapleader = " "
vim.keymap.set("n", "<leader>f", vim.cmd.Ex)

vim.keymap.set("n", "<leader>tn",vim.cmd.tabnew)
vim.keymap.set("n", "<leader>tc",vim.cmd.tabclose)
vim.keymap.set("n", "<leader>tl",vim.cmd.tabnext)
vim.keymap.set("n", "<leader>th",vim.cmd.tabprevious)

vim.keymap.set({"n", "v", "i"}, "<A-q>", "<ESC>")
