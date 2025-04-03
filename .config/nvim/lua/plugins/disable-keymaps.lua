return {
  "neovim/nvim-lspconfig",
  opts = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable ctrl+k
    keys[#keys + 1] = { "<c-k>", false, mode = "i" }
  end,
}
