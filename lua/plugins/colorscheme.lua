return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      contrast = "hard",
      palette_overrides = {
        dark0_hard = "#000000",
      },
      overrides = {
        -- Clear most syntax highlighting
        Keyword = { fg = "NONE" },
        Number = { fg = "NONE" },
        Constant = { fg = "NONE" },
        Function = { fg = "NONE" },
        Identifier = { fg = "NONE" },
        Type = { fg = "NONE" },
        Statement = { fg = "NONE" },
        PreProc = { fg = "NONE" },
        Special = { fg = "NONE" },
        Operator = { fg = "NONE" },
        Boolean = { fg = "NONE" },
        Character = { fg = "NONE" },
        Conditional = { fg = "NONE" },
        Repeat = { fg = "NONE" },
        Label = { fg = "NONE" },
        Exception = { fg = "NONE" },
        Comment = { fg = "#928374", italic = true },
        String = { fg = "#a89984" },
        Delimiter = { fg = "NONE" },
        ["@keyword.conditional"] = { fg = "NONE" },
        ["@keyword.repeat"] = { fg = "NONE" },
        ["@keyword.operator"] = { fg = "NONE" },
        ["@punctuation.bracket"] = { fg = "NONE" },
        ["@string"] = { fg = "#a89984" },
        ["@atom"] = { fg = "#a89984" },
        ["@constant.atom"] = { fg = "#a89984" },
        ["@constant"] = { fg = "#a89984" },
        ["@symbol"] = { fg = "#a89984" }, -- atoms
        ["@comment"] = { fg = "#928374", italic = true },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
