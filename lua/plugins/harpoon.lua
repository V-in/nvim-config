return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
      save_on_ui_close = true,
    },
  },
  keys = function()
    local keys = {
      {
        "<leader>H",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
      {
        "<leader>h",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon Quick Menu",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<leader>" .. i,
        function()
          local harpoon = require("harpoon")
          local harpoon_item = harpoon:list():get(i)

          -- If the buffer is already open in another window
          -- just switch to it, otherwise do the default behaviour
          if harpoon_item then
            local file_path = harpoon_item.value
            for _, win_id in ipairs(vim.api.nvim_list_wins()) do
              local buf_id = vim.api.nvim_win_get_buf(win_id)
              local buf_name = vim.api.nvim_buf_get_name(buf_id)
              local relative_buf = vim.fn.fnamemodify(buf_name, ":.")

              if relative_buf == file_path or buf_name == file_path then
                vim.api.nvim_set_current_win(win_id)
                return
              end
            end
          end

          harpoon:list():select(i)
        end,
        desc = "Harpoon to File " .. i,
      })
    end
    return keys
  end,
}
