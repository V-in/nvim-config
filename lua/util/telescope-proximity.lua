-- Proximity-based sorter for Telescope that combines fuzzy matching with directory proximity.
-- Algorithm: Files are scored using base_fuzzy_score * proximity_multiplier where:
--   1. Base fuzzy score comes from fzf/generic fuzzy matcher (lower = better match)
--   2. Proximity multiplier ranges from 0.1 to 1.0 based on directory relationship:
--      - Same directory: minimal multiplier (files appear first)
--      - Child directory: small multiplier (subdirectories prioritized)
--      - Sibling directory: medium multiplier (same parent folder)
--      - Other: larger multiplier (distant files appear last)
--   3. proximity_weight parameter (0-1) controls the influence of proximity vs fuzzy matching
local M = {}

function M.create_proximity_sorter(opts)
  opts = opts or {}
  local sorters = require("telescope.sorters")

  local proximity_weight = opts.proximity_weight or 0.3

  local current_buffer = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buffer)
  local current_dir = vim.fn.fnamemodify(current_file, ":h")

  local cwd = vim.fn.getcwd()
  if current_dir:sub(1, #cwd) == cwd then
    current_dir = current_dir:sub(#cwd + 2)
  end

  local base_sorter = sorters.get_generic_fuzzy_sorter()

  return sorters.Sorter:new({
    scoring_function = function(self, prompt, line)
      local score = base_sorter:scoring_function(prompt, line)
      if score < 0 then
        return -1
      end

      local file_dir = vim.fn.fnamemodify(line, ":h")

      local multiplier = 1.0

      local proximity_bonus = 1.0

      if file_dir == current_dir then
        proximity_bonus = 0.0
      elseif current_dir ~= "" and file_dir:find(current_dir, 1, true) == 1 then
        proximity_bonus = 0.3
      elseif current_dir ~= "" then
        local current_parent = current_dir:match("(.*/)")
        local file_parent = file_dir:match("(.*/)")
        if current_parent and file_parent and current_parent == file_parent then
          proximity_bonus = 0.5
        else
          proximity_bonus = 0.8
        end
      end

      multiplier = 1.0 - (proximity_weight * 0.9 * (1.0 - proximity_bonus))

      return score * multiplier
    end,
    highlighter = base_sorter.highlighter,
  })
end

return M
