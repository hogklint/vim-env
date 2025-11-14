return {
  {
    "tpope/vim-fugitive",
    keys = {
      {"<leader>dm", ":Gvdiff refs/remotes/origin/main...<CR>", { silent = true }},
      --{"<leader>s", ":Git<CR>", { silent = true }},
      {"<leader>b", ":Git blame -w -M<CR>", { silent = true }},
      {"<leader>e", ":Gedit<CR>", { silent = true }},
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
    keys = function()
      local gs = require("gitsigns")
      return {
        --{"<leader>hs", gs.stage_hunk, desc = "Stage hunk", mode = { "n", "x", "v" } },
        {"<leader>hs", ":Gitsigns stage_hunk<cr>", desc = "Stage hunk", mode = { "n", "x", "v" } },
        {'<leader>hr', ":Gitsigns reset_hunk<cr>", desc = "Reset hunk", mode = { "n", "x", "v" } },
        {"<leader>hS", gs.stage_buffer, "Stage Buffer"},
        {"<leader>hu", gs.undo_stage_hunk, "Undo Stage Hunk"},
        {"<leader>hR", gs.reset_buffer, "Reset Buffer"},
        {"<leader>hp", gs.preview_hunk_inline, "Preview Hunk Inline"},
        {"<leader>hb", function() gs.blame_line({ full = true }) end, "Blame Line"},
        {"<leader>hB", function() gs.blame() end, "Blame Buffer"},
        {"<leader>hd", gs.diffthis, "Diff This"},
        {"<leader>hD", function() gs.diffthis("~") end, "Diff This ~"},
        --{"ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk", mode = { "o", "x" }},
        {"]H", function() gs.nav_hunk("last") end, "Last Hunk"},
        {"[H", function() gs.nav_hunk("first") end, "First Hunk"},
        {
          "]h",
          function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gs.nav_hunk("next")
            end
          end,
          "Next Hunk"
        },
        {
          "[h",
          function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gs.nav_hunk("prev")
            end
          end,
          "Prev Hunk"
        },
      }
    end
  },
}
