return {
	{
		"olimorris/codecompanion.nvim",
		-- version = "^18.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/mcphub.nvim",
		},
		opts = {
			interactions = {
				chat = {
					adapter = "copilot",
					model = "claude-sonnet-4-5",
				},
			},
			-- NOTE: The log_level is in `opts.opts`
			-- opts = {
			-- 	log_level = "DEBUG",
			-- },
		},
	},
}
