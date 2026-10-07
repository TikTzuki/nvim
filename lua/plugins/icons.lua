return {
  "echasnovski/mini.icons",
  lazy = true,
  opts = {},
  init = function()
    -- Many plugins ask for nvim-web-devicons; serve mini.icons in its place.
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
