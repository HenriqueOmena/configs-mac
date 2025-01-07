-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "ts_ls", "eslint", "tailwindcss", "lua_lsp" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Configuração do TypeScript/TSX
lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
        -- Desative formatação automática pelo tsserver se você usar algo como prettier
        client.server_capabilities.documentFormattingProvider = false

        -- Atalhos úteis
        local opts = { noremap = true, silent = true }
        local buf_set_keymap = vim.api.nvim_buf_set_keymap
        buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
        buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    end,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
}

