return {
  "Mofiqul/vscode.nvim",
  event = "VeryLazy",
  config = function()
    if vim.g.colors_name == "vscode" then
      vim.cmd [[colorscheme vscode]]
    end
  end,
}
