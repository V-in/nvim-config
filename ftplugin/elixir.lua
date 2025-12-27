local testing = require("util.testing")

-- Elixir-specific monochrome highlight overrides
local monochrome_groups = {
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
  ["@symbol"] = { fg = "#a89984" },
  ["@comment"] = { fg = "#928374", italic = true },
  ["@string.special.symbol.elixir"] = { fg = "NONE", italic = true },
}

for group, opts in pairs(monochrome_groups) do
  vim.api.nvim_set_hl(0, group, opts)
end

vim.api.nvim_buf_create_user_command(0, "TestCurrentLineInTmux", function()
  local current_file = vim.fn.expand("%:p")
  local current_line = vim.fn.line(".")
  testing.send_to_test_pane("mix test " .. current_file .. ":" .. current_line)
end, { desc = "Run test at current line in testing window" })

vim.api.nvim_buf_create_user_command(0, "TestCurrentFileInTmux", function()
  local current_file = vim.fn.expand("%:p")
  testing.send_to_test_pane("mix test " .. current_file)
end, { desc = "Run the current file as a test in testing window" })

vim.keymap.set("n", "<leader>tt", ":TestCurrentLineInTmux<CR>", { buffer = true, desc = "Test current line in tmux" })
vim.keymap.set("n", "<leader>tT", ":TestCurrentFileInTmux<CR>", { buffer = true, desc = "Test entire file in tmux" })

local function go_to_pattern(pattern)
  return function()
    local saved_view = vim.fn.winsaveview()

    vim.cmd("normal! gg")

    local min_def_indent = nil
    while vim.fn.search("^\\s*def ", "W") > 0 do
      local line = vim.fn.getline(".")
      local indent = #(line:match("^%s*") or "")
      if not min_def_indent or indent < min_def_indent then
        min_def_indent = indent
      end
    end

    if not min_def_indent then
      vim.fn.winrestview(saved_view)
      return
    end

    vim.cmd("normal! gg")
    while vim.fn.search(pattern, "W") > 0 do
      local line = vim.fn.getline(".")
      local indent = #(line:match("^%s*") or "")
      vim.notify("Checking indent: " .. indent .. " vs min: " .. min_def_indent)
      if indent == min_def_indent then
        vim.cmd("normal! zz")
        return
      end
    end

    vim.fn.winrestview(saved_view)
  end
end

local function go_to_header()
  vim.cmd("normal! gg")

  local last_alias_line = 0
  while vim.fn.search("^\\s*alias ", "W") > 0 do
    last_alias_line = vim.fn.line(".")
  end

  if last_alias_line > 0 then
    vim.fn.cursor(last_alias_line, 1)
  else
    vim.fn.cursor(1, 1)
    if vim.fn.search("^\\s*@moduledoc", "W") > 0 then
      local line_content = vim.fn.getline(".")
      if string.match(line_content, '"""') then
        vim.fn.search('"""', "W")
      end
    elseif not vim.fn.search("^defmodule ", "W") then
      return
    end
  end

  vim.cmd("normal! zz")
end

vim.keymap.set("n", "gtr", go_to_pattern("^\\s*def render("), { buffer = true, desc = "Go to render function" })
vim.keymap.set("n", "gtu", go_to_pattern("^\\s*def update("), { buffer = true, desc = "Go to update function" })
vim.keymap.set(
  "n",
  "gta",
  go_to_pattern("^\\s*def attach_hook"),
  { buffer = true, desc = "Go to attach_hook function" }
)
vim.keymap.set(
  "n",
  "gtp",
  go_to_pattern("^\\s*def handle_params("),
  { buffer = true, desc = "Go to handle_params function" }
)
vim.keymap.set("n", "gtm", go_to_pattern("^\\s*def mount("), { buffer = true, desc = "Go to mount function" })
vim.keymap.set("n", "gte", go_to_pattern("^\\s*def handle_event("), { buffer = true, desc = "Go to handle_event" })
vim.keymap.set("n", "gth", go_to_header, { buffer = true, desc = "Go to header (after aliases or moduledoc)" })
