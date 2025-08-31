return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elixirls = {
          enabled = false,
          fetchDeps = false,
          enableTestLenses = true,
          suggestSpecs = true,
        },
        nextls = {
          enabled = true,
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
          cmd_env = {
            SKIP_WBXML = 0,
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
        show_symbol_lineno = true,
        icon_fetcher = function(_, bufnr, symbol)
          local ft = vim.api.nvim_get_option_value("ft", { buf = bufnr })
          if ft == "elixir" and symbol and symbol.elixir_keyword then
            return symbol.elixir_keyword
          end
          return false
        end,
      },
      preview_window = {
        auto_preview = true,
      },
      outline_items = {
        show_symbol_details = true,
        highlight_hovered_item = true,
      },
      providers = {
        priority = { "elixir", "lsp", "coc", "markdown", "norg" },
      },
    },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
  },
}
