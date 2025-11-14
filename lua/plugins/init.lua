return {
  --"mbbill/undotree",
  --"godlygeek/tabular",
  --"MattesGroeger/vim-bookmarks",
  --"hashivim/vim-terraform",
  --"NoahTheDuke/vim-just",
  --"chrisbra/vim-diff-enhanced",
  -- Autocomplete nvim config
  -- replace with lazydev.vim
  --"folke/neodev.nvim",
  -- Color column when max width is reached
  --Plug("m4xshen/smartcolumn.nvim",
  -- JSON and YAML schemas
  --"b0o/schemastore.nvim",
  --"towolf/vim-helm",

  {
    "hogklint/QFixToggle",
    keys = {
      { "<leader>o", "<cmd>QFix<cr>", desc = "Toggle quickfix list" },
    },
  },
  --"airblade/vim-rooter",
  "github/copilot.vim",

  "bergercookie/vim-debugstring",
  -- Enable repeat of vim-debugstring by pressing period
  "tpope/vim-repeat",

  -- Color scheme
  --"rebelot/kanagawa.nvim",
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
}
