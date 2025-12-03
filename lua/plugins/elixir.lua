return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elixirls = {
          enabled = false,
        },
        nextls = {
          enabled = false,
        },
        expert = {},
      },
      setup = {
        expert = function()
          vim.lsp.config("expert", {
            cmd = { "expert", "--stdio" },
            cmd_env = { SKIP_WBXML = "0" },
            root_markers = { "mix.exs", ".git" },
            filetypes = { "elixir", "eelixir", "heex" },
          })
          vim.lsp.enable("expert")
          return true
        end,
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
        auto_preview = false,
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
