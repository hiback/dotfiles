-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.env.SSH_TTY then
  vim.o.clipboard = "unnamedplus"
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = osc52.copy("+"),
      ["*"] = osc52.copy("*"),
    },
    paste = {
      -- Use internal register for paste
      ["+"] = function()
        return { vim.split(vim.fn.getreg('"'), "\n"), vim.fn.getregtype('"') }
      end,
      ["*"] = function()
        return { vim.split(vim.fn.getreg('"'), "\n"), vim.fn.getregtype('"') }
      end,
    },
  }
end
