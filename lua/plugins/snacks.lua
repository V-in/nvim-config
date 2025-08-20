return {
  "folke/snacks.nvim",
  keys = {
    {
      "<D-b>",
      function()
        Snacks.explorer()
      end,
      desc = "Toggle Explorer",
    },
    {
      "<C-Tab>",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Switch Buffer",
    },
    {
      "<D-w>",
      function()
        Snacks.bufdelete()
      end,
      desc = "Delete Buffer",
    },
  },
  opts = {
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 15, total = 100 }, -- Much faster (default is ~300)
      },
    },
  },
}
