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
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

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

    -- Stock live_grep with built-in refine (<C-Space> opens a filter over the current results).
    local function live_grep_with_refine()
      builtin.live_grep({
        attach_mappings = function(_, map)
          -- <C-Space> is often <Nul> in terminals; also provide <C-f> as a reliable fallback
          map("i", "<c-space>", actions.to_fuzzy_refine)
          map("i", "<c-@>", actions.to_fuzzy_refine) -- some terms send <Nul> for Ctrl-Space
          map("i", "<c-f>", actions.to_fuzzy_refine)
          return true
        end,
      })
    end
    vim.g.LiveGrepPathFilter = live_grep_with_refine
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
        function()
          vim.g.LiveGrepPathFilter()
        end,
        desc = "Live grep (text + path filter)",
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
