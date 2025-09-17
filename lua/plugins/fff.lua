return {
  "dmtrKovalenko/fff.nvim",
  build = "cargo build --release",
  opts = {
    debug = {
      enabled = true,
      show_scores = true,
    },
  },
  lazy = false,
  keys = {
    {
      "<leader><leader>",
      function()
        require("fff").find_files()
      end,
      desc = "FFFind files",
    },
  },
}
