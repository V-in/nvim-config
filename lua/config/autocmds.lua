-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--

-- Allow > and < to move between def/defp lines
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
  end,
})

-- After yanking text with change, add it to search history so that you can
-- change the next occurencies easily
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("ChangeToSearch", { clear = true }),
  callback = function()
    if vim.v.event.operator == "c" then
      local yanked_text = vim.fn.getreg('"')
      if yanked_text and yanked_text ~= "" then
        vim.fn.setreg("/", yanked_text)
        vim.fn.histadd("search", yanked_text)
        vim.cmd("let &hlsearch = &hlsearch")

        vim.notify("Registered to search: " .. yanked_text, vim.log.levels.INFO)
      end
    end
  end,
})
