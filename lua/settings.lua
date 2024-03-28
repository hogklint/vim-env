vim.g.mapleader = ","
vim.g.maplocalleader = "-"

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
vim.o.noerrorbells = true
vim.o.novisualbell = true

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
