return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "blade",
        "html",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },

        php = function(bufnr)
          local filename = vim.api.nvim_buf_get_name(bufnr)

          if filename:match("%.blade%.php$") then
            return { "blade-formatter" }
          end

          return { "pint" }
        end,
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local remove = {
        phpcs = true,
        ["php-cs-fixer"] = true,
      }

      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not remove[tool]
      end, opts.ensure_installed or {})
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft.php = nil
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          cmd = {
            "mise",
            "exec",
            "node@24",
            "--",
            vim.fn.stdpath("data") .. "/mason/bin/intelephense",
            "--stdio",
          },
        },
      },
    },
  },
}
