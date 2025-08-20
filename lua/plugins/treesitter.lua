return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "elixir",
      "heex",
      "html",
      "eex",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    auto_install = true,
  },
}
