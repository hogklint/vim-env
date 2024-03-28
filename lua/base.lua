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

-- Search with very magic (pure regex)
vim.keymap.set("n", "<space>", "/\\v")

-- Save the thing
vim.keymap.set("n", "<leader>w", ":w<CR>")

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
vim.o.laststatus = 2

-- Cursor
vim.o.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", {ctermbg=0, cterm=nil, term=nil})

-- Turn backup off
vim.o.nobackup = true
vim.o.nowritebackup = true
vim.o.noswapfile = true
vim.o.noautoread = true

-- No folds
vim.o.nofoldenable = true

-- Set tab behaviour
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true
-- C-style indeting
vim.o.cindent = true
-- Tabs in Go
vim.o.expandtab = true
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = "*.go",
  command = "set noexpandtab",
})

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Prefer unix format
vim.opt.fileformats = {"unix", "dos"}

