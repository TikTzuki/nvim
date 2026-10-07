return {
  -- Full git UI: status, staging, commit, branch log graph
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Git status (Neogit)" },
      { "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Git commit" },
      { "<leader>gl", "<cmd>Neogit log<cr>", desc = "Git log / branch history" },
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff working tree" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "History of current file" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "History of whole repo" },
    },
    opts = {
      integrations = { diffview = true },
      graph_style = "unicode",
    },
  },

  -- Gutter markers for added/changed/removed lines + hunk actions
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "]h", function() gs.nav_hunk("next") end, "Next changed hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev changed hunk")
        map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
      end,
    },
  },
}
