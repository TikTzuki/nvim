-- In a git commit message buffer, <leader>ga generates a commit message
-- from the staged diff using the Claude CLI (fast haiku model).
local PROMPT = table.concat({
  "You are writing a git commit message for the staged diff provided on stdin.",
  "First line: imperative summary under 72 chars (conventional commit style, e.g. 'fix: ...', 'feat: ...').",
  "If the change is non-trivial, add a blank line then 1-3 short bullet points explaining the why.",
  "Output ONLY the commit message text - no code fences, no commentary.",
}, " ")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "NeogitCommitMessage" },
  callback = function(args)
    vim.keymap.set("n", "<leader>ga", function()
      vim.notify("Generating commit message with Claude…", vim.log.levels.INFO)
      vim.system({ "git", "diff", "--cached" }, { text = true }, function(diff)
        if not diff.stdout or diff.stdout == "" then
          vim.schedule(function()
            vim.notify("No staged changes to describe", vim.log.levels.WARN)
          end)
          return
        end
        vim.system(
          { "claude", "--model", "haiku", "-p", PROMPT },
          { stdin = diff.stdout, text = true },
          function(res)
            vim.schedule(function()
              local msg = vim.trim(res.stdout or "")
              if res.code ~= 0 or msg == "" then
                vim.notify("Claude failed: " .. vim.trim(res.stderr or "unknown error"), vim.log.levels.ERROR)
                return
              end
              vim.api.nvim_buf_set_lines(args.buf, 0, 0, false, vim.split(msg, "\n"))
              vim.notify("Commit message inserted — edit and :wq to commit", vim.log.levels.INFO)
            end)
          end
        )
      end)
    end, { buffer = args.buf, desc = "AI: generate commit message" })
  end,
})
