-- <leader>? opens CHEATSHEET.md from this config in a right-hand split,
-- read-only, with markdown rendering if render-markdown is around.
-- which-key still pops up on any prefix pause; this key is the sheet.
local sheet = vim.fn.stdpath("config") .. "/CHEATSHEET.md"

local function open_cheatsheet()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(win)) == sheet then
      vim.api.nvim_win_close(win, false)
      return
    end
  end
  vim.cmd("botright vsplit " .. vim.fn.fnameescape(sheet))
  vim.api.nvim_win_set_width(0, math.max(60, math.floor(vim.o.columns * 0.4)))
  vim.bo.readonly = true
  vim.bo.modifiable = false
  vim.wo.wrap = false
  vim.wo.number = false
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, desc = "Close cheat sheet" })
  pcall(vim.cmd, "RenderMarkdown enable")
end

vim.api.nvim_create_user_command("Cheatsheet", open_cheatsheet, { desc = "Toggle the keymap cheat sheet" })
vim.keymap.set("n", "<leader>?", open_cheatsheet, { desc = "Cheat sheet (toggle)" })
