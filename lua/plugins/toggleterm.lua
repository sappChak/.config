return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    direction = "horizontal",
    size = 10,
    open_mapping = [[<c-\>]],
    config = function()
      require("config.toggleterm").config()
    end,
  },
}
