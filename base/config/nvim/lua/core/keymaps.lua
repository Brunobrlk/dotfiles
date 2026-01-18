vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true } )

local opts = { noremap = true, silent = true }

vim.keymap.set('n', '<C-k>', '<cmd>wincmd k<cr>', opts)
vim.keymap.set('n', '<C-j>', '<cmd>wincmd j<cr>', opts)
vim.keymap.set('n', '<C-h>', '<cmd>wincmd h<cr>', opts)
vim.keymap.set('n', '<C-l>', '<cmd>wincmd l<cr>', opts)


vim.keymap.set('n', '<C-l>', '<cmd>wincmd l<cr>', opts)
vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', opts)

vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', opts)
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', opts)
vim.keymap.set('n', '<leader>Q', '<cmd>quitall<cr>', opts)
