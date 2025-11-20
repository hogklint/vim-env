return {
	{
		"junegunn/fzf",
		{ ["dir"] = "~/.fzf", ["do"] = "./install --all" },
	},
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "nvim-mini/mini.icons" },
		opts = function()
			local actions = require("fzf-lua").actions
			return {
				fzf_opts = {
					["--layout"] = "default",
					--["--info"] = "inline",
					--["--height"] = "80%",
					--["--preview-window"] = "right:10%",
				},
				winopts = {
					preview = {
						layout = "flex",
						horizontal = "right:50%",
						-- "flip_columns" is the threshold width (in characters).
						-- If window width is less than, it switches to vertical (preview at bottom/top).
						-- Increase this value to make the flex layout kick in "earlier"
						flip_columns = 170,
					},
				},
				grep = {
					actions = {
						["ctrl-e"] = { actions.grep_lgrep },
						["ctrl-g"] = false,
					},
				},
			}
		end,
		keys = function()
			local fzflua = require("fzf-lua")
			return {
				{ "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
				{ "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
				{
					"<leader>l",
					"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
					desc = "Switch Buffer",
				},
				{ "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Root Dir)" },
				{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
				{ "<c-p>", "<cmd>FzfLua files<cr>", desc = "Find Files (Root Dir)" },
				-- find
				{ "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
				--{ "<leader>fc", LazyVim.pick.config_files(), desc = "Find Config File" },
				{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files (Root Dir)" },
				{
					"<leader>fF",
					function()
						fzflua.files({ root = false })
					end,
					desc = "Find Files (cwd)",
				},
				{ "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
				{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
				{
					"<leader>fR",
					function()
						fzflua.oldfiles({ cwd = vim.uv.cwd() })
					end,
					desc = "Recent (cwd)",
				},
				-- git
				{ "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
				{ "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
				-- search
				{ '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
				{ "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
				{ "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
				{ "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
				{ "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
				{ "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
				{ "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
				{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Root Dir)" },
				{
					"<leader>sG",
					function()
						fzflua.live_grep({ root = false })
					end,
					desc = "Grep (cwd)",
				},
				{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
				{ "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
				{ "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
				{ "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
				{ "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
				{ "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
				{ "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
				{ "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
				{ "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
				{ "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Word (Root Dir)" },
				--{ "<leader>sw", "<cmh>grep_visual<cr>", mode = "v", desc = "Selection (Root Dir)" },
				{ "<leader>uC", "<cmd>FzfLua colorschemes<cr>", desc = "Colorscheme with Preview" },
				{
					"<leader>ss",
					function()
						fzflua.lsp_document_symbols({
							regex_filter = symbols_filter,
						})
					end,
					desc = "Goto Symbol",
				},
				{
					"<leader>sS",
					function()
						fzflua.lsp_live_workspace_symbols({
							regex_filter = symbols_filter,
							fuzzy = true,
						})
					end,
					desc = "Goto Symbol (Workspace)",
				},
				{
					"<leader>sp",
					function()
						local a = fzflua.fzf_exec({ "asdf", "qwer" })
						print("[fzf.lua:98] DEBUGGING STRING ==> " .. tostring(a))
					end,
					desc = "Find projects",
				},
			}
		end,
	},
	--{
	--  "junegunn/fzf.vim",
	--    keys = {
	--      {
	--        "<C-p>",
	--        ":Files<CR>",
	--        mode = {"n"},
	--        silent = true,
	--        desc = "Search files",
	--      },
	--      {
	--        "<leader>l",
	--        ":Buffers<CR>",
	--        mode = { "n" },
	--        silent = true,
	--        desc = "Search open buffers",
	--      },
	--      {
	--        "<leader>r",
	--        ":History<CR>",
	--        mode = { "n" },
	--        silent = true,
	--        desc = "Search file history",
	--      },
	--      {
	--        mode = { "n" },
	--        "<leader>f",
	--        ":BTags<CR>",
	--        silent = true,
	--        desc = "Search tags in current buffer",
	--      },
	--      {
	--        "q/",
	--        ":History/<CR>",
	--        mode = "n",
	--        silent = true,
	--        desc = "Search in search history",
	--      },
	--  },
	--},
}
