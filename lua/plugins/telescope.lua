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
      "<D-p>",
      "<cmd>Telescope frecency workspace=CWD<cr>",
      desc = "Frecency (Smart File Finder)",
    },
    {
      "<M-p>",
      "<cmd>Telescope frecency workspace=CWD<cr>",
      desc = "Frecency (Smart File Finder)",
    },
    {
      "<D-f>",
      "<cmd>Telescope current_buffer_fuzzy_find<cr>",
      desc = "Search in Current Buffer",
    },
    {
      "<M-f>",
      "<cmd>Telescope current_buffer_fuzzy_find<cr>",
      desc = "Search in Current Buffer",
    },
    {
      "<D-S-f>",
      "<cmd>Telescope live_grep<cr>",
      desc = "Search in all git tracked files",
    },
    {
      "<M-S-f>",
      "<cmd>Telescope live_grep<cr>",
      desc = "Search in all git tracked files",
    },
    {
      "<M-S-p>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Commands",
    },
    {
      "<D-S-p>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Commands",
    },
  },
}
