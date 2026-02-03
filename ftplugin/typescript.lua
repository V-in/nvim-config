-- TypeScript monochrome highlight overrides
-- Start white, add color selectively

local comment_color = "#928374"
local string_color = "#a89984" -- warm gray for strings

-- [EXPERIMENTAL] Clear everything to default foreground
-- Use :Inspect on any token to see what highlight groups apply
-- Add new groups here as you discover colored tokens that should be monochrome
local groups_to_clear = {
  -- Base vim syntax
  "Keyword",
  "Number",
  "Constant",
  "Function",
  "Identifier",
  "Statement",
  "PreProc",
  "Special",
  "Operator",
  "Boolean",
  "Character",
  "Conditional",
  "Repeat",
  "Label",
  "Exception",
  "String",
  "Delimiter",
  "Type",
  "Comment",

  -- Treesitter
  "@variable",
  "@variable.builtin",
  "@variable.parameter",
  "@variable.member",
  "@constant",
  "@constant.builtin",
  "@constant.macro",
  "@module",
  "@namespace",
  "@label",
  "@string",
  "@string.regex",
  "@string.escape",
  "@string.special",
  "@character",
  "@character.special",
  "@boolean",
  "@number",
  "@number.float",
  "@type",
  "@type.builtin",
  "@type.definition",
  "@type.qualifier",
  "@attribute",
  "@property",
  "@function",
  "@function.builtin",
  "@function.call",
  "@function.macro",
  "@function.method",
  "@function.method.call",
  "@constructor",
  "@operator",
  "@keyword",
  "@keyword.function",
  "@keyword.operator",
  "@keyword.return",
  "@keyword.conditional",
  "@keyword.repeat",
  "@keyword.import",
  "@keyword.export",
  "@keyword.exception",
  "@keyword.modifier",
  "@keyword.type",
  "@punctuation.bracket",
  "@punctuation.delimiter",
  "@punctuation.special",
  "@comment",
  "@comment.documentation",
  "@tag",
  "@tag.attribute",
  "@tag.delimiter",

  -- JSX/TSX
  "@tag.tsx",
  "@tag.typescript",
  "@tag.builtin",
  "@tag.builtin.tsx",
  "@constructor.tsx",
  "@constructor.typescript",

  -- Embedded HTML/markup
  "@markup.heading",
  "@markup.heading.html",
  "@markup.link",
  "@markup.link.html",
  "@markup.raw",
  "@markup.raw.html",
  "@markup.strong",
  "@markup.italic",
  "@none",
  "@none.typescript",
  "@none.html",

  -- LSP semantic tokens (higher priority than treesitter)
  "@lsp.type.class",
  "@lsp.type.decorator",
  "@lsp.type.enum",
  "@lsp.type.enumMember",
  "@lsp.type.function",
  "@lsp.type.interface",
  "@lsp.type.keyword",
  "@lsp.type.macro",
  "@lsp.type.method",
  "@lsp.type.namespace",
  "@lsp.type.number",
  "@lsp.type.operator",
  "@lsp.type.parameter",
  "@lsp.type.property",
  "@lsp.type.string",
  "@lsp.type.struct",
  "@lsp.type.type",
  "@lsp.type.typeParameter",
  "@lsp.type.variable",
  "@lsp.mod.declaration",
  "@lsp.mod.readonly",
  "@lsp.mod.defaultLibrary",
  "@lsp.mod.async",
  "@lsp.typemod.variable.readonly",
  "@lsp.typemod.variable.declaration",
  "@lsp.typemod.variable.defaultLibrary",
  "@lsp.typemod.function.declaration",
  "@lsp.typemod.function.async",
  "@lsp.typemod.class.declaration",
  "@lsp.typemod.class.defaultLibrary",
  "@lsp.typemod.parameter.declaration",
  "@lsp.typemod.property.declaration",
  "@lsp.typemod.method.declaration",
  "@lsp.typemod.method.async",
}

for _, group in ipairs(groups_to_clear) do
  vim.api.nvim_set_hl(0, group, { fg = "NONE" })
end

-- Comments: dim and italic
vim.api.nvim_set_hl(0, "Comment", { fg = comment_color, italic = true })
vim.api.nvim_set_hl(0, "@comment", { fg = comment_color, italic = true })
vim.api.nvim_set_hl(0, "@comment.documentation", { fg = comment_color, italic = true })

-- Strings: warm gray
vim.api.nvim_set_hl(0, "String", { fg = string_color })
vim.api.nvim_set_hl(0, "@string", { fg = string_color })
vim.api.nvim_set_hl(0, "@string.regex", { fg = string_color })
vim.api.nvim_set_hl(0, "@string.escape", { fg = string_color })
vim.api.nvim_set_hl(0, "@string.special", { fg = string_color })
vim.api.nvim_set_hl(0, "@lsp.type.string", { fg = string_color })
