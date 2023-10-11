local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- move selected text
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- better window management
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- open netrw in the current buffers directory
map("n", "<leader>dd", "<cmd>Lexplore %:p:h<CR>", opts)

-- open netrw in the current buffers directory
map("n", "<leader>da", "<cmd>Lexplore<CR>", opts)

-- show diagnostic message
map("n", "<leader>e", '<cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>')

-- initialize new tmux session with tmux-sessionizer
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- format current buffer
map("n", "<leader>f", vim.lsp.buf.format)
