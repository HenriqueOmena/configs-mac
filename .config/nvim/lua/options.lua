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
