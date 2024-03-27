local Plug = vim.fn["plug#"]

vim.call("plug#begin")
-- Autocomplete nvim config
Plug("folke/neodev.nvim")
-- Plug("junegunn/vim-easy-align")
-- replace with stevearc/qf_helper.nvim?
Plug("hogklint/QFixToggle")
Plug("tpope/vim-fugitive")
Plug("mbbill/undotree")
Plug("chrisbra/vim-diff-enhanced")
-- Plug("MattesGroeger/vim-bookmarks")
-- Plug("markonm/traces.vim")
-- if vim.fn.executable("node") == 1 then
--   Plug("neoclide/coc.nvim", {["branch"] = "release"})
-- end
-- 
Plug("junegunn/fzf", { ["dir"] = "~/.fzf", ["do"] = "./install --all" })
Plug("junegunn/fzf.vim")
-- Plug("airblade/vim-rooter")
vim.call("plug#end")

-- FZF
vim.keymap.set("n", "<C-p>", ":Files<CR>", {silent = true})
vim.keymap.set("n", "<leader>l", ":Buffers<CR>", {silent = true})
vim.keymap.set("n", "<leader>r", ":History<CR>", {silent = true})
vim.keymap.set("n", "<leader>f", ":BTags<CR>", {silent = true})
vim.keymap.set("n", "q/", ":History/<CR>", {silent = true})

-- Undotree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", {silent = true})

-- Fugitive
vim.keymap.set("n", "<leader>d", ":Gvdiff<CR>", {silent = true})
vim.keymap.set("n", "<leader>dm", ":Gvdiff refs/remotes/origin/HEAD...<CR>", {silent = true})
vim.keymap.set("n", "<leader>s", ":Git<CR>", {silent = true})
vim.keymap.set("n", "<leader>b", ":Git blame -w -M<CR>", {silent = true})
vim.keymap.set("n", "<leader>e", ":Gedit<CR>", {silent = true})
--vim.keymap.set("n", "<f2>", ":Ggrep <cword> *<CR><CR>", {silent = true})


-- QFix
vim.keymap.set("n", "<leader>o", ":QFix<CR>")
