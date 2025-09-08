return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      {
        "folke/which-key.nvim",
        config = function()
          local mark_letter = "Z"
          _G.eject_mark_set = false

          local function toggle_mark()
            if _G.eject_mark_set then
              local ok = pcall(vim.cmd, "normal! `" .. mark_letter)
              if ok then
                vim.cmd("delmarks " .. mark_letter)
                _G.eject_mark_set = false
              else
                _G.eject_mark_set = false
              end
            else
              vim.cmd("mark " .. mark_letter)
              _G.eject_mark_set = true
            end
          end

          vim.keymap.set("n", "<BS>", toggle_mark, {
            desc = "Toggle position mark",
            silent = false,
          })

          vim.keymap.set("n", "<leader><BS>", function()
            if _G.eject_mark_set then
              pcall(vim.cmd, "delmarks " .. mark_letter)
              _G.eject_mark_set = false
            end
          end, {
            desc = "Clear eject mark",
            silent = false,
          })
        end,
      },
    },
    opts = function(_, opts)
      local eject_component = {
        function()
          if _G.eject_mark_set then
            return "⏏ EJECT"
          end
          return ""
        end,
        color = { fg = "#ff9e64", gui = "bold" },
        cond = function()
          return _G.eject_mark_set
        end,
      }

      table.insert(opts.sections.lualine_x, 1, eject_component)

      return opts
    end,
  },
}
