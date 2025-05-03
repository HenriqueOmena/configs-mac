-- Carrega configurações padrão do NvChad, mas ignora o lua_ls
local default_config = require("nvchad.configs.lspconfig")
local M = {}

-- Sobrescreve a função defaults para evitar configuração automática do lua_ls
M.on_attach = default_config.on_attach
M.on_init = default_config.on_init
M.capabilities = default_config.capabilities

local lspconfig = require("lspconfig")

-- EXAMPLE
local servers = { "html", "cssls", "eslint", "tailwindcss" }
local nvlsp = M -- Usa nossa versão modificada das configurações padrão

-- lsps with default config
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	})
end

-- Configuração específica para TypeScript
lspconfig.tsserver.setup({
	on_attach = function(client, bufnr)
		-- Desativa formatação pelo tsserver para evitar conflitos com Prettier
		client.server_capabilities.documentFormattingProvider = false

		-- Atalhos úteis para TypeScript
		local opts = { noremap = true, silent = true }
		local buf_set_keymap = vim.api.nvim_buf_set_keymap
		buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	end,
	capabilities = nvlsp.capabilities,
	filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
})

-- Configuração explícita para desativar o lua_ls
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.diagnostic.disable(0) -- Desativa diagnósticos para arquivos Lua
	end,
})

-- Retorna o módulo modificado
return M
