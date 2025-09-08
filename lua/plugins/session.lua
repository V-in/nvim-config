local function is_diff_session()
  if vim.o.diff then
    return true
  end

  local buffers = vim.fn.getbufinfo()
  for _, buf in ipairs(buffers) do
    if buf.name:match("^hunk://") then
      return true
    end
  end

  return false
end

return {
  -- Auto-restore last session on startup
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
        nested = true,
        once = true,
        callback = function()
          if vim.fn.argc() == 0 and not is_diff_session() then
            vim.schedule(function()
              require("persistence").load()
            end)
          end
        end,
      })
    end,
  },
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
    },
  },
}
