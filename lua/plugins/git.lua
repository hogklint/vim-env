return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
    keys = {
      {
        "<leader>hs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage hunk",
      },
      {'<leader>hr', function() require("gitsigns").reset_hunk() end, desc = "Reset hunk"},
    },
  },
}
