-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-- leader
vim.g.mapleader = " "

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<leader>h', '<C-w>h', opts)
vim.keymap.set('n', '<leader>k', '<C-w>j', opts)
vim.keymap.set('n', '<leader>j', '<C-w>k', opts)
vim.keymap.set('n', '<leader>l', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- others
vim.keymap.set('n', 'j', 'k', opts)
vim.keymap.set('n', 'k', 'j', opts)
vim.keymap.set('n', 'K', '', opts)
vim.keymap.set('n', 'J', '', opts)
vim.keymap.set('n', 'c', '', opts)
vim.keymap.set('n', 'aa', '^', opts)
vim.keymap.set('n', ';;', '$', opts)
vim.keymap.set('n', 'yw', 'yiw', opts)

vim.keymap.set('n', '<leader>s', ':w<CR>', opts)
vim.keymap.set('n', '<leader>b', ':q<CR>', opts)

-- terminal
vim.keymap.set('n', '<leader>t', ':sp | terminal<CR>', opts)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', opts)
vim.keymap.set('t', 'jk', '<C-\\><C-n>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

vim.keymap.set('v', 'j', 'k', opts)
vim.keymap.set('v', 'k', 'j', opts)

-----------------
-- Insert mode --
-----------------

-- use jk to replace <Esc> in Insert mode
vim.keymap.set('i', 'jk', '<Esc>')

-- nvim-tree
vim.keymap.set("n", "<F2>", ":NvimTreeToggle<CR>", opts)
