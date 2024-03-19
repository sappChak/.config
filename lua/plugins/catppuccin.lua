return {
  "catppuccin/nvim",
  config = function()
    if vim.g.colors_name == "catppuccin" then
      vim.cmd("colorscheme catppuccin")
    end
  end,
}
