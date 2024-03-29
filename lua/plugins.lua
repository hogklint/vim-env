local Plug = vim.fn["plug#"]

vim.call("plug#begin")
-- Autocomplete nvim config
Plug("folke/neodev.nvim")
-- replace with stevearc/qf_helper.nvim?
Plug("hogklint/QFixToggle")
Plug("tpope/vim-fugitive")
Plug("mbbill/undotree")
Plug("chrisbra/vim-diff-enhanced")
Plug("MattesGroeger/vim-bookmarks")
-- if vim.fn.executable("node") == 1 then
--   Plug("neoclide/coc.nvim", {["branch"] = "release"})
-- end
Plug("junegunn/fzf", { ["dir"] = "~/.fzf", ["do"] = "./install --all" })
Plug("junegunn/fzf.vim")
Plug("m4xshen/smartcolumn.nvim")
Plug("airblade/vim-rooter")
Plug("godlygeek/tabular")
Plug("averms/black-nvim", {["do"] = ":UpdateRemotePlugins"})
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


-- Smartcolumn (colorcolumn)
require("smartcolumn").setup(
  {colorcolumn = "120", disabled_filetypes = {"help", "text"}}
)


-- Python Black
-- The plugin uses nvim's python env (see vim.g.python3_host_prog)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.py",
  command = "call BlackSync()",
})

-- vim-bookmarks
-- Default keymaps
-- mm: new
-- mi: new with annotation
-- mn: goto next
-- mp: goto previous
-- ma: list
-- mc: clear bufffer
-- mx: clear all

-- Tabular usage:
-- :Tabularize /<pattern>/<format>
--
-- Formats:
-- l: left alignment
-- r: right alignment
-- c: center alignment
-- number: padding
--
-- E:g. r0 or l8 or r0c5
