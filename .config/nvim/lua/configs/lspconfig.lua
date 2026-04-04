-- Carrega configurações padrão do NvChad, mas ignora o lua_ls
local default_config = require("nvchad.configs.lspconfig")
local M = {}

-- Sobrescreve a função defaults para evitar configuração automática do lua_ls
M.on_attach = default_config.on_attach
M.on_init = default_config.on_init
M.capabilities = default_config.capabilities

local lspconfig = require("lspconfig")

-- EXAMPLE
local servers = { "html", "cssls", "eslint", "tailwindcss", "ts_ls" }
local nvlsp = M -- Usa nossa versão modificada das configurações padrão

-- lsps with default config
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = nvlsp.on_attach,
		on_init = nvlsp.on_init,
		capabilities = nvlsp.capabilities,
	})
end

-- Configuração do Lua Language Server
lspconfig.lua_ls.setup({
	on_attach = nvlsp.on_attach,
	on_init = nvlsp.on_init,
	capabilities = nvlsp.capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" }, -- Reconhece 'vim' como global
			},
			workspace = {
				-- Faz o language server reconhecer os arquivos do Neovim
				library = {
					vim.fn.expand("$VIMRUNTIME/lua"),
					vim.fn.stdpath("config") .. "/lua",
				},
				-- Não analisa todas as bibliotecas (performance)
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

-- Configuração específica para TypeScript
lspconfig.ts_ls.setup({
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

-- Retorna o módulo modificado
return M
