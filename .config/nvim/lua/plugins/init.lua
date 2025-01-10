return {
  {
    "nvim-lua/plenary.nvim",
    lazy = true, -- Carregar apenas quando necessário
  },
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css"
      },
    },
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,                                                                           -- Carregar imediatamente
    config = function()
      vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true }) -- Atalho para abrir o LazyGit
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    lazy = false, -- Garante que ele carregue imediatamente
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,  -- Formatação para HTML, CSS, JS, etc.
          null_ls.builtins.diagnostics.eslint_d, -- Diagnóstico do ESLint
          null_ls.builtins.formatting.stylua.with({
            extra_args = { "--config-path", vim.fn.expand("~/.config/stylua/stylua.toml") },
          }), -- Formatação para Lua
        },
        -- Configuração para auto-formatar ao salvar
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "tailwindcss-language-server",
        "typescript",
        "stylua"
      },
      automatic_installation = true
    }
  }
}
