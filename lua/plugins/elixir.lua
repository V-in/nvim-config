return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elixirls = {
          enabled = true,
          fetchDeps = false,
          enableTestLenses = true,
          suggestSpecs = true,
        },
        nextls = {
          enabled = false,
          spitfire = true,
          init_options = {
            mix_env = "dev",
            mix_target = "host",
            experimental = {
              completions = {
                enable = true,
              },
            },
          },
        },
      },
    },
  },
  {
    "hedyhli/outline.nvim",
    dependencies = {
      "epheien/outline-treesitter-provider.nvim",
    },
    opts = {
      symbols = {
        show_symbol_details = true,
        show_symbol_lineno = false,
      },
      preview_window = {
        auto_preview = true,
      },
      outline_items = {
        show_symbol_details = true,
        highlight_hovered_item = true,
      },
      providers = {
        priority = { "lsp", "coc", "markdown", "norg" },
      },
    },
    keys = {
      { "<D-o>", "<cmd>Outline<CR>", desc = "Toggle outline" },
      { "<A-o>", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
  },
}
