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
  keys = {
    {
      "<leader>p",
      function()
        local builtin = require("telescope.builtin")
        local proximity = require("util.telescope-proximity")

        local proximity_sorter = proximity.create_proximity_sorter({
          proximity_weight = 0.2, -- 0.0 = pure fuzzy, 1.0 = strong proximity
          show_debug = false, -- Set to true to see debug output
          debug_limit = 5,
        })

        builtin.find_files({
          sorter = proximity_sorter,
          max_results = 20,
        })
      end,
      desc = "Find Files (proximity-based)",
    },
    {
      "<leader>ff",
      "<cmd>Telescope current_buffer_fuzzy_find<cr>",
      desc = "Search in Current Buffer",
    },
    {
      "<leader>fF",
      "<cmd>Telescope live_grep<cr>",
      desc = "Search in all git tracked files",
    },
    {
      "<leader><leader>",
      "<cmd>Telescope buffers<cr>",
      desc = "Search buffers",
    },
  },
}
