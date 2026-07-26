-- File navigation for the multi-repo workspace: snacks.picker (fuzzy find/grep),
-- oil.nvim (directory editing), harpoon2 (pinned hot files), mini.icons (filetype icons).
return {
  -- Filetype icons for pickers, explorer, and oil. Requires a Nerd Font in the
  -- terminal (JetBrainsMono Nerd Font is installed). The mock makes plugins
  -- that ask for nvim-web-devicons use mini.icons transparently.
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- snacks.nvim is already installed as a claudecode.nvim dependency; this spec
  -- merges in the picker/explorer config and keymaps.
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = { enabled = true },
      explorer = { enabled = true },
    },
    keys = {
      -- Workspace-wide (cwd = wherever you launched nvim, e.g. the meta-repo root)
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart find files" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files (workspace)" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep (workspace)" },
      { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word under cursor", mode = { "n", "x" } },
      -- Scoped to the git repo of the file you're editing — the right default
      -- when the workspace holds ~20 nested service repos.
      { "<leader>fF", function() Snacks.picker.files({ cwd = vim.fs.root(0, ".git") }) end, desc = "Find files (current repo)" },
      { "<leader>fG", function() Snacks.picker.grep({ cwd = vim.fs.root(0, ".git") }) end, desc = "Grep (current repo)" },
      -- Jump-back-to-things
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
      { "<leader>fs", function() Snacks.picker.resume() end, desc = "Resume last picker" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      -- Tree sidebar when you want a spatial view
      { "<leader>e", function() Snacks.explorer() end, desc = "File explorer" },
    },
  },

  -- Edit the filesystem like a buffer: `-` opens the parent directory; rename,
  -- move, delete files with normal vim edits, then :w to apply.
  {
    "stevearc/oil.nvim",
    opts = {
      view_options = { show_hidden = true },
      skip_confirm_for_simple_edits = true,
    },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" },
    },
  },

  -- Pin the handful of files you're actively juggling; jump with <leader>1..4.
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon: pin file" },
      { "<leader>hh", function() local h = require("harpoon") h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon: menu" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },
}
