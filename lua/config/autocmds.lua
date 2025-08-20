-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = "elixir",
  callback = function(args)
    local pattern = "\\v^\\s*(def|defp)\\s+\\w+"

    vim.keymap.set("n", ">", function()
      vim.cmd("/" .. pattern)
      vim.cmd("nohlsearch")
      vim.cmd("normal! zz")
    end, { buffer = args.buf, desc = "Next def/defp" })

    vim.keymap.set("n", "<", function()
      vim.cmd("?" .. pattern)
      vim.cmd("nohlsearch")
      vim.cmd("normal! zz")
    end, { buffer = args.buf, desc = "Previous def/defp" })

    print("Test mappings set: <leader>fn and <leader>fp")
  end,
})
