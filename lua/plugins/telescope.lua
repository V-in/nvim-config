return {
  "nvim-telescope/telescope-frecency.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").setup({
      extensions = {
        frecency = {
          default_workspace = "CWD",
          matcher = "fuzzy",
        },
      },
    })
    require("telescope").load_extension("frecency")
  end,
  keys = {
    {
      "<leader>p",
      "<cmd>Telescope frecency workspace=CWD<cr>",
      desc = "Frecency (Smart File Finder)",
    },
    {
      "<leader>ff",
      "<cmd>Telescope current_buffer_fuzzy_find<cr>",
      desc = "Search in Current Buffer",
    },
    {
      "<leader>fF",
      "<cmd>Telescope live_grep<cr>",
      desc = "Search in all git tracked files",
    },
    {
      "<leader><leader>",
      "<cmd>Telescope buffers<cr>",
      desc = "Search buffers",
    },
  },
}
