return {
  "folke/snacks.nvim",
  keys = {},
  opts = {
    scratch = {
      ft = "markdown",
      filekey = {
        cwd = true,
        count = true,
        branch = false,
      },
    },
    scroll = {
      enabled = false,
      animate = {
        duration = { step = 15, total = 100 }, -- Much faster (default is ~300)
      },
    },
  },
}
