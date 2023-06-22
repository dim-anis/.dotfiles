local opts = {noremap = true, silent = true}
local map = vim.keymap.set

-- better window management
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- show diagnostic message
map("n", "<space>e", '<cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>')

-- initialize new tmux session with tmux-sessionizer
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')
