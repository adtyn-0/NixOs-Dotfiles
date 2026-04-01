vim.keymap.set("n", "<leader>lz", ":Lazy<CR>", { desc = "Open Lazy.nvim" })

--Clipboard keybindings [Training wheels]
-- vim.keymap.set({ "n", "v" }, "<leader>c", '"+y', { desc = "Copy to clipboard" })
-- vim.keymap.set("n", "<leader>C", '"+Y', { desc = "Copy line to clipboard" })
-- vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from clipboard" })
-- vim.keymap.set("i", "<leader>p", '<C-r>+', { desc = "Paste in insert mode" })

-- Actually goated
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Safe paste in visual mode" })

vim.keymap.set("n", "<leader>e", ":NvimTreeOpen<CR>" , {desc = "Go to Explorer" })

-- Keyboard shortcuts
vim.keymap.set("i", "<C-H>", "<C-w>", { noremap = true, desc = "Ctrl+Backspace to delete word" })
-- vim.keymap.set("n", "<C-a>","ggVG",{ noremap = true, desc = "Select All"})
-- vim.keymap.set()

-- Clear all yank registers and system clipboard
vim.keymap.set("n", "<leader>cc", function()
---- Clear unnamed, * and + registers
     vim.fn.setreg('"', {})
     vim.fn.setreg('*', {})
     vim.fn.setreg('+', {})
---- Clear numbered registers "1 through "9
     for i = 1, 9 do
      vim.fn.setreg(tostring(i), {})
      end

    print("Clipboard and yank registers cleared!")
    end, { desc = "Clear clipboard/yank registers" })

-- -- Code Runner
-- vim.keymap.set('n', '<leader>r', ':RunFile<CR>', { noremap = true, silent = true, desc = "Run file (generic)" })
-- vim.keymap.set('n', '<leader>R', ':RunProject<CR>', { noremap = true, silent = true, desc = "Run project" })
-- vim.keymap.set('n', '<leader>rt', ':RunFile tab<CR>', { noremap = true, silent = true, desc = "Run file in tab" })
-- vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = true, desc = "Close runner" })


