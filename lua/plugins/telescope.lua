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
      "<D-S-p>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Commands",
    },
  },
}
