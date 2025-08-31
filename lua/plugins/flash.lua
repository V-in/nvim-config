return {
  "folke/flash.nvim",
  opts = {
    jump = {
      register = true,
      nohlsearch = false,
    },
    search = {
      mode = "search",
    },
  },
  config = function(_, opts)
    require("flash").setup(opts)

    vim.api.nvim_set_hl(0, "FlashLabel", {
      fg = "#282828",
      bg = "#fb4934",
      bold = true,
    })

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
        vim.api.nvim_set_hl(0, "FlashLabel", {
          fg = "#282828",
          bg = "#fb4934",
          bold = true,
        })
      end,
    })
  end,
}
