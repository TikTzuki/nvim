-- Insert a newline in a terminal TUI prompt (Claude Code) instead of submitting.
-- Claude treats ESC+CR (what Option+Enter sends) as "newline, don't submit", so we
-- write those bytes straight to the PTY. Bypasses the outer terminal, which may not
-- emit a distinct code for Shift+Enter at all.
local function soft_newline()
  local chan = vim.b.terminal_job_id
  if chan then
    vim.api.nvim_chan_send(chan, "\27\r")
  end
end

-- <S-CR>/<C-CR> only arrive from terminals that encode them (kitty protocol); the
-- <C-j> binding is the one that always reaches Neovim, whatever the terminal.
-- <C-g> is deliberately NOT mapped: Claude Code binds it to "edit the prompt in
-- $VISUAL/$EDITOR" (chat:externalEditor), and a terminal-mode map here would
-- shadow that. It passes through to Claude untouched.
for _, key in ipairs({ "<S-CR>", "<C-CR>", "<M-CR>", "<C-j>" }) do
  vim.keymap.set("t", key, soft_newline, { desc = "Newline in terminal prompt (no submit)" })
end
