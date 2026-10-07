return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "echasnovski/mini.icons" },
  keys = {
    { "<leader>m", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown render" },
  },
  opts = {
    completions = { lsp = { enabled = false } },
  },
}
