vim.g.mapleader = ","
vim.g.maplocalleader = "-"

-- Always show the statusline
vim.o.laststatus = 2

-- Cursor
vim.o.cursorline = true
vim.api.nvim_set_hl(0, "CursorLine", {ctermbg=0})

-- Color column
vim.api.nvim_set_hl(0, "ColorColumn", {ctermbg="magenta"})
-- Using smartcolumn plugin instead of static value
-- vim.o.colorcolumn = "120"

-- Turn backup off
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.autoread = false

-- No folds
vim.o.foldenable = false

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

-- Line wrap length (when using `gq`)
vim.o.textwidth = 120

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Lines to keep above/below cursor
vim.o.scrolloff = 7

-- Do not redraw when running macros
vim.o.lazyredraw = true

-- Search with magic (regex-ish)
vim.o.magic = true

-- No sound on errors
vim.o.errorbells = false
vim.o.visualbell = false

-- Briefly jump to matching bracket
vim.o.showmatch = true
vim.o.matchtime = 3

-- Commands to remember
vim.o.history = 400

-- Files to ignore when using wildcars
vim.opt.wildignore = {"*.o", "*.obj", ".git", "*.idl"}

vim.opt.diffopt = {"algorithm:patience", "indent-heuristic", "iwhiteall"}

-- Spell check on file types
ftypes = {"markdown", "gitcommit"}
for i, ftype in ipairs(ftypes) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ftype,
    command = "setlocal spell spelllang=en_us",
  })
end

-- Highlight trailing whitespace
vim.api.nvim_set_hl(0, "ExtraWhitespace", {ctermbg="darkgreen"})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  command = "let w:m1=matchadd('ExtraWhitespace', '\\s\\+$\\| \\+\\ze\\t', -1)",
})

-- This is where pynvim and black is installed. Not sure how that works with a per-project venv
vim.g.python3_host_prog = "/home/jhogklint/.local/venv/nvim/bin/python"
