return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "elixir",
      "heex",
      "html",
      "eex",
      "json",
      "lua",
      "vim",
      "vimdoc",
      "markdown",
      "markdown_inline",
      "bash",
      "typescript",
      "tsx",
      "javascript",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    auto_install = true,
  },
}
