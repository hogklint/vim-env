return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = {
			{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
		},
		keys = {
			{
				"<leader>ra",
				function()
					require("opencode").ask("", { submit = true })
				end,
				desc = "Ask opencode…",
				mode = "n",
			},
			{
				"<leader>ra",
				function()
					require("opencode").ask("@this: ", { submit = true })
				end,
				desc = "Ask opencode…",
				mode = "v",
			},
			{
				"<leader>rr",
				function()
					require("opencode").select({ submit = true })
				end,
				desc = "Execute opencode action…",
				mode = "n",
			},
			-- {
			-- 	"<leader>r.",
			-- 	function()
			-- 		require("opencode").toggle()
			-- 	end,
			-- 	desc = "Toggle opencode",
			-- 	mode = "n",
			-- },
			-- {
			-- 	"<leader>ro",
			-- 	function()
			-- 		return require("opencode").operator("@this ")
			-- 	end,
			-- 	desc = "Add range to opencode",
			-- 	mode = "n",
			-- },
			-- {
			-- 	"<leader>roo",
			-- 	function()
			-- 		return require("opencode").operator("@this ") .. "_"
			-- 	end,
			-- 	desc = "Add line to opencode",
			-- 	mode = "n",
			-- },
			{
				"<leader>ru",
				function()
					require("opencode").command("session.half.page.up")
				end,
				desc = "Scroll opencode up",
				mode = "n",
			},
			{
				"<leader>rd",
				function()
					require("opencode").command("session.half.page.down")
				end,
				desc = "Scroll opencode down",
				mode = "n",
			},
		},
		-- config = function()
		-- 	---@type opencode.Opts
		-- 	--vim.g.opencode_opts = {
		-- 	--	-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
		-- 	--}

		-- 	-- -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o…".
		-- 	-- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
		-- 	-- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
		-- end,
	},
	--{
	--	"olimorris/codecompanion.nvim",
	--	-- version = "^18.0.0",
	--	dependencies = {
	--		"nvim-lua/plenary.nvim",
	--		"nvim-treesitter/nvim-treesitter",
	--		"ravitemer/mcphub.nvim",
	--	},
	--	opts = {
	--		interactions = {
	--			chat = {
	--				adapter = "copilot",
	--				model = "claude-sonnet-4-5",
	--			},
	--		},
	--		-- NOTE: The log_level is in `opts.opts`
	--		-- opts = {
	--		-- 	log_level = "DEBUG",
	--		-- },
	--	},
	--},
}
