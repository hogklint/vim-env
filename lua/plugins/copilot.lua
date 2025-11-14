return {
	{
		"github/copilot.vim",

		-- Lazy-load on insert mode
		--event = "InsertEnter",

		config = function()
			local map = vim.keymap.set

			map("i", "<C-l>", 'copilot#Accept("<CR>")', {
				expr = true,
				replace_keycodes = false,
				silent = true,
				noremap = true,
			})

			--map("i", "<C-j>", "<Plug>(copilot-next)", { silent = true })
			--map("i", "<C-k>", "<Plug>(copilot-previous)", { silent = true })
			map("i", "<C-d>", "<Plug>(copilot-dismiss)", { silent = true })
		end,
	},
}
