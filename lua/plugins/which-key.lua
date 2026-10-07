-- Press <space> (or any prefix) and pause: a popup lists the mappings that
-- continue from there, using the `desc` each spec already provides.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = 400, -- ms before the popup appears; a fast typist never sees it
    spec = {
      { "<leader>a", group = "AI / Claude" },
      { "<leader>b", group = "buffers" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>h", group = "harpoon" },
    },
  },
}
