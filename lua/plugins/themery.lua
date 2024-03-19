return {
  "zaldih/themery.nvim",
  config = function()
    require("themery").setup({
      themes_dir = "~/.config/nvim/lua/themes/",
    })
  end,
}
