return {
  "akinsho/bufferline.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = { "echasnovski/mini.icons" },
  opts = {
    options = {
      mode = "buffers",
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      show_buffer_close_icons = true,
      separator_style = "thin",
    },
  },
  keys = {
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer tab" },
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer tab" },
    { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer tab" },
    { "<leader>bd", "<cmd>bdelete<cr>", desc = "Close buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
  },
}
