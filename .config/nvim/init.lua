vim.g.smart_splits_multiplexer_integration = vim.env.TMUX and "tmux" or false

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
