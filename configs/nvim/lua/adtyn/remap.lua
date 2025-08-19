vim.keymap.set("n", "<leader>lz", ":Lazy<CR>", { desc = "Open Lazy.nvim" })

--Clipboard keybindings
vim.keymap.set({ "n", "v" }, "<leader>c", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("n", "<leader>C", '"+Y', { desc = "Copy line to clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("i", "<leader>p", '<C-r>+', { desc = "Paste in insert mode" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Safe paste in visual mode" })

vim.keymap.set("n", "<leader>e", ":NvimTreeOpen<CR>" , {desc = "Go to Explorer" })

vim.keymap.set("i", "<C-H>", "<C-w>", { noremap = true, desc = "Ctrl+Backspace to delete word" })

