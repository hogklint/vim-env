local Plug = vim.fn["plug#"]

vim.call("plug#begin")
-- replace with stevearc/qf_helper.nvim?
Plug("hogklint/QFixToggle")
Plug("tpope/vim-fugitive")
Plug("mbbill/undotree")
Plug("chrisbra/vim-diff-enhanced")
Plug("MattesGroeger/vim-bookmarks")
Plug("junegunn/fzf", { ["dir"] = "~/.fzf", ["do"] = "./install --all" })
Plug("junegunn/fzf.vim")
Plug("airblade/vim-rooter")
Plug("godlygeek/tabular")
Plug("averms/black-nvim", { ["do"] = ":UpdateRemotePlugins" })
Plug("bergercookie/vim-debugstring")
Plug("hashivim/vim-terraform")

-- Color scheme
--Plug("rebelot/kanagawa.nvim")
Plug("catppuccin/nvim", { ["as"] = "catppuccin" })

-- Autocomplete nvim config
Plug("folke/neodev.nvim")

-- Enable repeat of vim-debugstring by pressing period
Plug("tpope/vim-repeat")

-- Color column when max width is reached
Plug("m4xshen/smartcolumn.nvim")

-- JSON and YAML schemas
Plug("b0o/schemastore.nvim")
Plug("towolf/vim-helm")

-- LSP and auto complete stuff
Plug("neovim/nvim-lspconfig")
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug 'hrsh7th/cmp-path'
-- Plug 'hrsh7th/cmp-buffer'
-- Plug 'hrsh7th/cmp-cmdline'
-- Insert auto complete with snipet plugin
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
-- Show function signatures as your call them
Plug("ray-x/lsp_signature.nvim")

vim.call("plug#end")

-- Color scheme
vim.cmd("colorscheme catppuccin-mocha")

-- FZF
vim.keymap.set("n", "<C-p>", ":Files<CR>", { silent = true })
vim.keymap.set("n", "<leader>l", ":Buffers<CR>", { silent = true })
vim.keymap.set("n", "<leader>r", ":History<CR>", { silent = true })
vim.keymap.set("n", "<leader>f", ":BTags<CR>", { silent = true })
vim.keymap.set("n", "q/", ":History/<CR>", { silent = true })

-- Undotree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { silent = true })

-- Fugitive
vim.keymap.set("n", "<leader>d", ":Gvdiff<CR>", { silent = true })
vim.keymap.set("n", "<leader>dm", ":Gvdiff refs/remotes/origin/HEAD...<CR>", { silent = true })
vim.keymap.set("n", "<leader>s", ":Git<CR>", { silent = true })
vim.keymap.set("n", "<leader>b", ":Git blame -w -M<CR>", { silent = true })
vim.keymap.set("n", "<leader>e", ":Gedit<CR>", { silent = true })
--vim.keymap.set("n", "<f2>", ":Ggrep <cword> *<CR><CR>", {silent = true})


-- QFix
vim.keymap.set("n", "<leader>o", ":QFix<CR>")


-- Smartcolumn (colorcolumn)
require("smartcolumn").setup(
	{ colorcolumn = "120", disabled_filetypes = { "help", "text" } }
)


-- Python Black
-- The plugin uses nvim's python env (see vim.g.python3_host_prog)
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.py",
	command = "call BlackSync()",
})


--
-- nvim-cmp
--
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		-- The <Tab> and <S-Tab> mapping functions mirror the behaviour of Super-Tab i.e. auto-complete when tabbing instead
		-- of just moving in the list and then auto-complete with <CR>
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
		--["<C-Space>"] = cmp.mapping.complete(),
		--["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
	}, {
		{ name = "buffer" },
	}),
	preselect = cmp.PreselectMode.None,
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

-- vim-debugstring
-- Default keymaps
-- <leader>ds: normal print
-- <leader>dS: print with expression
-- <leader>DS: print with c-expression
