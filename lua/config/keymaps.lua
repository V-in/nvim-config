-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Quickfix stuff
vim.keymap.set("n", "<leader>]q", ":cnext<CR>", { desc = "Next Quickfix Item" })
vim.keymap.set("n", "<leader>[q", ":cprev<CR>", { desc = "Previous Quickfix Item" })
vim.keymap.set("n", "<leader>]Q", ":clast<CR>", { desc = "Last Quickfix Item" })
vim.keymap.set("n", "<leader>[Q", ":cfirst<CR>", { desc = "First Quickfix Item" })
vim.keymap.set("n", "<leader>[Q", ":cfirst<CR>", { desc = "First Quickfix Item" })
vim.keymap.set("n", "<leader>xr", ":call setqflist([])<CR>", { desc = "Reset quickfix" })

-- Copy file path (relative to project root) to clipboard
vim.keymap.set("n", "<leader>cf", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path)
end, { desc = "Copy file path" })

-- Git
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope git_status<cr>", { desc = "Git status" })

vim.keymap.set("n", "<leader>fG", function()
  local files = vim.fn.systemlist('jj diff -r "trunk()..@" --name-only --no-pager')
  require("telescope.pickers")
    .new({}, {
      prompt_title = "Changed Files (trunk..@)",
      finder = require("telescope.finders").new_table({ results = files }),
      sorter = require("telescope.config").values.file_sorter(),
      previewer = require("telescope.previewers").new_termopen_previewer({
        get_command = function(entry)
          return { "jj", "diff", "-r", "trunk()..@", entry.value }
        end,
      }),
    })
    :find()
end, { desc = "JJ changed files" })
