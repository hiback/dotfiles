return {
  "keaising/im-select.nvim",
  cond = not os.getenv("SSH_TTY"),
  config = function()
    require("im_select").setup({})
  end,
}
