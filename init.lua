-- Leader key must be set before lazy.nvim loads
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Render 24-bit colors in the embedded terminal (Claude Code's pickers use
-- subtle RGB highlights that wash out under 256-color approximation).
vim.opt.termguicolors = true

-- In terminal mode (e.g. the Claude panel), keys normally go to the terminal
-- program, so Ctrl-w window commands don't work. These mappings restore them.
vim.keymap.set("t", "<C-w>h", [[<C-\><C-n><C-w>h]], { desc = "Window left" })
vim.keymap.set("t", "<C-w>j", [[<C-\><C-n><C-w>j]], { desc = "Window down" })
vim.keymap.set("t", "<C-w>k", [[<C-\><C-n><C-w>k]], { desc = "Window up" })
vim.keymap.set("t", "<C-w>l", [[<C-\><C-n><C-w>l]], { desc = "Window right" })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = false },
})
