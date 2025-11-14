return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    local ok, err = pcall(telescope.load_extension, "fzf")
    if not ok then
      vim.notify("Failed to load fzf-native")
    end
  end,
  keys = function(_, keys)
    -- Drop any LazyVim default for <leader>fF so this always runs live_grep
    keys = vim.tbl_filter(function(key)
      return key[1] ~= "<leader>fF"
    end, keys or {})

    vim.list_extend(keys, {
      {
        "<leader>p",
        function()
          require("fff").find_files()
        end,
        desc = "Smart search",
      },
      {
        "<leader>ff",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Search in Current Buffer",
      },
      {
        "<leader>/",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find({
            fuzzy = false,
            skip_empty_lines = true,
          })
        end,
        desc = "Search current buffer (non-fuzzy)",
      },
      {
        "<leader>fF",
        "<cmd>Telescope live_grep<cr>",
        desc = "Search in all git tracked files",
      },
      {
        "<leader><leader>",
        "<cmd>Telescope buffers<cr>",
        desc = "Smart search",
      },
    })

    return keys
  end,
}
