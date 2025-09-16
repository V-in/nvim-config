local testing = require("util.testing")

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

