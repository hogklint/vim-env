return {
  "hogklint/QFixToggle",
  "tpope/vim-fugitive",
  "mbbill/undotree",
  "chrisbra/vim-diff-enhanced",
  "MattesGroeger/vim-bookmarks",
  "junegunn/fzf", { ["dir"] = "~/.fzf", ["do"] = "./install --all" },
  "junegunn/fzf.vim",
  "airblade/vim-rooter",
  "godlygeek/tabular",
  "bergercookie/vim-debugstring",
  "hashivim/vim-terraform",
  "github/copilot.vim",
  "NoahTheDuke/vim-just",

  -- Color scheme
  --"rebelot/kanagawa.nvim",
  "catppuccin/nvim", { ["as"] = "catppuccin" },

  -- Autocomplete nvim config
  "folke/neodev.nvim",

  -- Enable repeat of vim-debugstring by pressing period
  "tpope/vim-repeat",

  -- Color column when max width is reached
  --Plug("m4xshen/smartcolumn.nvim",

  -- JSON and YAML schemas
  "b0o/schemastore.nvim",
  "towolf/vim-helm",

  -- LSP and auto complete stuff
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  'hrsh7th/cmp-path',
  -- 'hrsh7th/cmp-buffer'
  -- 'hrsh7th/cmp-cmdline'
  -- Insert auto complete with snipet plugin
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',
  -- Show function signatures as your call them
  "ray-x/lsp_signature.nvim",
}
