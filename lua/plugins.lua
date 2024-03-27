local Plug = vim.fn["plug#"]

vim.call("plug#begin")
-- Autocomplete nvim config
Plug("folke/neodev.nvim")
-- Plug("junegunn/vim-easy-align")
-- Plug("nomme/QFixToggle")
-- Plug("tpope/vim-fugitive")
-- Plug("mbbill/undotree")
-- Plug("chrisbra/vim-diff-enhanced")
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
