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

-- Telescope bindings
map('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
map('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

map('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
map('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
