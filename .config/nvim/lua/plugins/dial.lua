return {
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", false, mode = { "n", "x" } },
      { "<C-x>", false, mode = { "n", "x" } },
      { "g<C-a>", false, mode = { "n", "x" } },
      { "g<C-x>", false, mode = { "n", "x" } },
      {
        "g=",
        function()
          require("dial.map").manipulate("increment", "normal")
        end,
        desc = "Increment",
        mode = "n",
      },
      {
        "g-",
        function()
          require("dial.map").manipulate("decrement", "normal")
        end,
        desc = "Decrement",
        mode = "n",
      },
      {
        "g=",
        function()
          require("dial.map").manipulate("increment", "visual")
        end,
        desc = "Increment",
        mode = "x",
      },
      {
        "g-",
        function()
          require("dial.map").manipulate("decrement", "visual")
        end,
        desc = "Decrement",
        mode = "x",
      },
    },
  },
}
