return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      numbers = function(opts)
        local marks = require("harpoon"):list().items
        local bufname = vim.fn.bufname(opts.id)

        for i, mark in ipairs(marks) do
          if bufname == mark.value then
            return tostring(i)
          end
        end
        return ""
      end,

      sort_by = function(a, b)
        local aname = vim.fn.bufname(a.id)
        local bname = vim.fn.bufname(b.id)
        local ha, hb = 999, 999

        for i, mark in ipairs(require("harpoon"):list().items) do
          if mark.value == aname then
            ha = i
          end
          if mark.value == bname then
            hb = i
          end
        end

        return ha < hb
      end,
    },
  },
}

