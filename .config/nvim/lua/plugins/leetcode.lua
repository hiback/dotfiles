return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- required by telescope
    "MunifTanjim/nui.nvim",

    -- optional
    "nvim-treesitter/nvim-treesitter",
    -- "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    -- configuration goes here
    ---@type lc.lang
    lang = "cpp",
    ---@type string
    arg = "leet",
    ---@type lc.storage
    storage = {
      home = "~/leetcode",
      cache = "~/leetcode/.cache",
    },
  },
}
