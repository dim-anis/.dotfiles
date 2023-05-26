local opts = {noremap = true, silent = true}
local map = vim.keymap.set

map('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')

map({ 'n', 'v' }, '<Space>', '<Nop>', opts)
map('n', '<leader><leader>', ':Telescope buffers<CR>', opts)

-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- paste over currently selected text without yanking it
map('v', 'p', '"_dp')
map('v', 'P', '"_dP')
