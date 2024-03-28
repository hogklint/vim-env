vim.g.mapleader = ","

-- Substitue escpe
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kk", "<Esc>")

-- Create new lines
vim.keymap.set("n", "oo", "o<Esc>k")
vim.keymap.set("n", "<S-o><S-o>", "<S-o><Esc>j")

-- Navigation
vim.keymap.set("n", "<F1>", ":Explore<CR>")

-- Treat wrapped row as unwrapped
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Search
vim.keymap.set("n", "<space>", "/")

-- Save the thing
vim.keymap.set("n", "<leader>w", ":w!<CR>")

-- Split navigation
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Clear search highlight
vim.keymap.set("n", "<leader><CR>", ":noh<CR>", {silent = true})

-- Paste in insert mode
vim.keymap.set("i", "<leader>p", '<C-R>"')

-- Quickfix shortcuts
vim.keymap.set("n", "<leader>n", ":cn<CR>")
vim.keymap.set("n", "<leader>p", ":cp<CR>")
vim.keymap.set("n", "<leader>c", ":cc<CR>")

-- Always show the statusline
vim.opt.laststatus = 2
