return {
  "folke/flash.nvim",
  opts = {
    search = {
      mode = "search",
    },
  },
  config = function(_, opts)
    require("flash").setup(opts)

    -- This plays nicely with gruvbox.
    -- It sets the jump characters to be
    -- red background and dark letters

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
