return {
  "aaronik/treewalker.nvim",
  keys = {
    {
      "<",
      function()
        -- Set up one-time autocmd to center after cursor moves
        vim.api.nvim_create_autocmd("CursorMoved", {
          once = true,
          callback = function()
            vim.cmd("normal! zz")
          end,
        })
        require("gitsigns").prev_hunk()
      end,
      mode = "n",
      desc = "Previous change",
    },
    {
      ">",
      function()
        -- Set up one-time autocmd to center after cursor moves
        vim.api.nvim_create_autocmd("CursorMoved", {
          once = true,
          callback = function()
            vim.cmd("normal! zz")
          end,
        })
        require("gitsigns").next_hunk()
      end,
      mode = "n",
      desc = "Next change",
    },
  },
  opts = {
    highlight = false,
  },
}
