require "nvchad.options"

-- add yours here!

local o = vim.opt

o.cursorlineopt = 'both' -- to renable cursorline!
-- Configurações gerais do Neovim
local opt = vim.opt

-- Desativa arquivos de swap para evitar mensagens de aviso
opt.swapfile = false

-- Garante que os buffers sejam sempre modificáveis
opt.modifiable = true

-- Outras configurações úteis
opt.clipboard = "unnamedplus"  -- Usa o clipboard do sistema
opt.undofile = true            -- Persistência de desfazer
opt.updatetime = 250           -- Atualização mais rápida
opt.timeoutlen = 300           -- Tempo para completar sequências de teclas

-- Melhor navegação entre janelas
opt.splitright = true          -- Split vertical abre à direita
opt.splitbelow = true          -- Split horizontal abre abaixo

-- Highlight on yank - feedback visual ao copiar texto
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
	desc = "Highlight yanked text",
})
