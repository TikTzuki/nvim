return {
  "folke/tokyonight.nvim",
  -- A colorscheme must load eagerly and before other plugins define highlights.
  lazy = false,
  priority = 1000,
  opts = {
    -- "storm" (default) | "night" (darker) | "moon" | "day" (light)
    style = "storm",
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
  end,
}
