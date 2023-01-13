vim.keymap.set('n', '<leader>w','<cmd>write<cr>') -- save file
vim.keymap.set({'n','x'}, 'cy', '"+y') -- copy to clipboard
vim.keymap.set({'n','x'}, 'cp', '"+p') -- paste from clipboard
vim.keymap.set({'n','x'}, 'x', '"_x') -- delete without changing the registers 
vim.keymap.set('n', '<leader>a', ':keepjumps norma! ggVG<cr>') -- select al text in current buffer