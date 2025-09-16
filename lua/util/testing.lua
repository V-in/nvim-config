local M = {}

function M.send_to_test_pane(string)
  local sessions_output = vim.fn.system("tmux list-sessions -F '#{session_name}'")
  if vim.v.shell_error ~= 0 then
    vim.notify("No tmux sessions found", vim.log.levels.ERROR)
    return
  end

  local sessions = vim.split(sessions_output, "\n", { trimempty = true })
  
  for _, session in ipairs(sessions) do
    local windows_output = vim.fn.system("tmux list-windows -t " .. session .. " -F '#{window_name}:#{window_index}'")
    if vim.v.shell_error == 0 then
      local windows = vim.split(windows_output, "\n", { trimempty = true })
      for _, window_info in ipairs(windows) do
        local window_name, window_index = window_info:match("^(.+):(%d+)$")
        if window_name == "testing" then
          local target = session .. ":" .. window_index
          vim.fn.system("tmux send-keys -t " .. target .. " '" .. string .. "' C-m")
          if vim.v.shell_error == 0 then
            vim.notify("Sent to testing pane in session: " .. session, vim.log.levels.INFO)
          else
            vim.notify("Failed to send to testing pane", vim.log.levels.ERROR)
          end
          return
        end
      end
    end
  end
  
  vim.notify("No 'testing' window found in any tmux session", vim.log.levels.WARN)
end

return M
