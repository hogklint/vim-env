return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      -- nvim-cmp recommended setup
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      'hrsh7th/cmp-cmdline',
      "hrsh7th/cmp-path",
    },
    opts = function()
      -- Register nvim-cmp lsp capabilities
      vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
    end
  },

  -- TODO: Optionally add intergration with snip-plugin
}
