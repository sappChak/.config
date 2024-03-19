return {
  "ellisonleao/gruvbox.nvim",
  config = function()
    if vim.g.colors_name == "gruvbox" then
      vim.cmd("colorscheme gruvbox")
    end
  end,
}
