return {
  "folke/snacks.nvim",
  keys = function(_, keys)
    -- Drop LazyVim's default <leader>fF file finder so our telescope live_grep wins
    return vim.tbl_filter(function(key)
      return key[1] ~= "<leader>fF"
    end, keys)
  end,
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
