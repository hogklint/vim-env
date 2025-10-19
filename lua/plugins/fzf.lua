return {
  {
    "junegunn/fzf",
    { ["dir"] = "~/.fzf", ["do"] = "./install --all" },
  },
  {
    "junegunn/fzf.vim",
      keys = {
        {
          "<C-p>",
          ":Files<CR>",
          mode = {"n"},
          silent = true,
          desc = "Search files",
        },
        {
          "<leader>l",
          ":Buffers<CR>",
          mode = { "n" },
          silent = true,
          desc = "Search open buffers",
        },
        {
          "<leader>r",
          ":History<CR>",
          mode = { "n" },
          silent = true,
          desc = "Search file history",
        },
        {
          mode = { "n" },
          "<leader>f",
          ":BTags<CR>",
          silent = true,
          desc = "Search tags in current buffer",
        },
        {
          "q/",
          ":History/<CR>",
          mode = "n",
          silent = true,
          desc = "Search in search history",
        },
    },
  },
}
