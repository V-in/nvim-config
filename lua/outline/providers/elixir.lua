local M = {
  name = "elixir",
}

local utils = require("outline.utils")

---@param bufnr integer
---@param config table?
---@return boolean ft_is_elixir
function M.supports_buffer(bufnr, config)
  local ft = utils.buf_get_option(bufnr, "ft")
  if config and config.filetypes then
    for _, ft_check in ipairs(config.filetypes) do
      if ft_check == ft then
        return true
      end
    end
  end
  return ft == "elixir"
end

-- Helper function to trim whitespace
local function trim(s)
  return s:match("^%s*(.-)%s*$")
end

-- Helper function to extract arguments from multiline function definition
local function extract_function_args(lines, start_line)
  local args = ""
  local paren_count = 0
  local found_opening = false

  for i = start_line, #lines do
    local line = lines[i]:match("^%s*(.-)%s*$")

    for char in line:gmatch(".") do
      if char == "(" then
        paren_count = paren_count + 1
        found_opening = true
      elseif char == ")" then
        paren_count = paren_count - 1
      end

      if found_opening then
        args = args .. char
      end

      if found_opening and paren_count == 0 then
        -- Remove outer parentheses and return trimmed
        return trim(args:sub(2, -2))
      end
    end

    if found_opening and i < #lines then
      args = args .. " "
    end
  end

  return ""
end

---@return outline.ProviderSymbol[]
function M.handle_elixir()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local symbols = {}
  local module_stack = {}
  local current_module = nil
  local depth = 0

  for line_num, line in ipairs(lines) do
    local trimmed = line:match("^%s*(.-)%s*$")

    if
      trimmed:match("^defmodule%s")
      or trimmed:match("^def%s")
      or trimmed:match("^defp%s")
      or trimmed:match("^defmacro%s")
      or trimmed:match("^defmacrop%s")
      or trimmed:match("%sdo$")
      or trimmed:match("%sdo%s")
    then
      depth = depth + 1
    end

    local module_match = trimmed:match("^defmodule%s+([%w%.]+)")
    if module_match then
      local entry = {
        kind = 2, -- Module
        name = module_match,
        elixir_keyword = "defmodule", -- Add keyword field
        depth_start = depth, -- Track the depth when module was opened
        selectionRange = {
          start = { character = 0, line = line_num - 1 },
          ["end"] = { character = #line, line = line_num - 1 },
        },
        range = {
          start = { character = 0, line = line_num - 1 },
          ["end"] = { character = 0, line = line_num - 1 },
        },
        children = {},
      }

      -- If we're nested in another module, add as child
      if #module_stack > 0 then
        local parent = module_stack[#module_stack]
        table.insert(parent.children, entry)
      else
        table.insert(symbols, entry)
      end

      table.insert(module_stack, entry)
      current_module = entry
    end

    local def_match = trimmed:match("^def%s+([%w_!?]+)")
    if def_match and not trimmed:match("^defmodule") and not trimmed:match("^defp%s") then
      local detail = extract_function_args(lines, line_num)
      local entry = {
        kind = 12, -- Function
        name = def_match,
        detail = detail,
        elixir_keyword = "def", -- Add keyword field
        selectionRange = {
          start = { character = 0, line = line_num - 1 },
          ["end"] = { character = #line, line = line_num - 1 },
        },
        range = {
          start = { character = 0, line = line_num - 1 },
          ["end"] = { character = 0, line = line_num - 1 },
        },
        children = {},
      }

      if current_module then
        table.insert(current_module.children, entry)
      else
        table.insert(symbols, entry)
      end
    end

    local defp_match = trimmed:match("^defp%s+([%w_!?]+)")
    if defp_match then
      local detail = extract_function_args(lines, line_num)
      local entry = {
        kind = 12,
        name = defp_match,
        detail = detail,
        elixir_keyword = "defp",
        selectionRange = {
          start = { character = 0, line = line_num - 1 },
          ["end"] = { character = #line, line = line_num - 1 },
        },
        range = {
          start = { character = 0, line = line_num - 1 },
          ["end"] = { character = 0, line = line_num - 1 },
        },
        children = {},
      }

      if current_module then
        table.insert(current_module.children, entry)
      else
        table.insert(symbols, entry)
      end
    end

    if trimmed == "end" then
      if depth > 0 then
        depth = depth - 1
        if #module_stack > 0 and depth < module_stack[#module_stack].depth_start then
          local completed_module = table.remove(module_stack)
          completed_module.range["end"].line = line_num - 1
          current_module = module_stack[#module_stack] or nil
        end
      end
    end
  end

  for _, module in ipairs(module_stack) do
    module.range["end"].line = #lines - 1
  end

  return symbols
end

---@param on_symbols fun(symbols?:outline.ProviderSymbol[], opts?:table)
---@param opts table
function M.request_symbols(on_symbols, opts)
  on_symbols(M.handle_elixir(), opts)
end

return M
