require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<M-BS>", "<C-w>", { desc = "Delete previous word in insert mode" })
map("n", "K", function()
	-- Exibe a mensagem de hover (informações do erro/warning)
	vim.lsp.buf.hover()

	-- Pega o diagnóstico da linha atual
	local diag = vim.diagnostic.get(0, { lnum = vim.fn.line(".") - 1 })[1]
	if diag then
		-- Copia a mensagem para o clipboard
		vim.fn.setreg("+", diag.message)
		print("Copied diagnostic: " .. diag.message) -- Exibe uma confirmação
	end
end, { desc = "Show LSP hover and copy diagnostic" })

-- Terminal toggle com Ctrl+\
map("n", "<C-\\>", function()
	local term = require("toggleterm")
	term.toggle(1, nil, nil, "float")
	-- Força o foco no terminal e entra no modo de inserção
	vim.defer_fn(function()
		vim.cmd("startinsert")
	end, 50)
end, { desc = "Toggle floating terminal", noremap = true, silent = true })

-- Adiciona um mapeamento para alternar o terminal a partir do modo terminal
map("t", "<C-\\>", function()
	local term = require("toggleterm")
	term.toggle(1)
end, { desc = "Toggle terminal from terminal mode", noremap = true, silent = true })

-- Adiciona mapeamento para esconder o terminal com ESC
map("t", "<Esc>", function()
	local term = require("toggleterm")
	term.toggle(1)
end, { desc = "Hide terminal with ESC", noremap = true, silent = true })

-- Mantém o mapeamento antigo como alternativa
map("n", "<leader>tt", function()
	local term = require("toggleterm")
	term.toggle(1, nil, nil, "float")
	vim.defer_fn(function()
		vim.cmd("startinsert")
	end, 50)
end, { desc = "Toggle floating terminal (alternative)", noremap = true, silent = true })

map("t", "<leader>tt", function()
	local term = require("toggleterm")
	term.toggle(1)
end, { desc = "Toggle terminal from terminal mode (alternative)", noremap = true, silent = true })

-- Adiciona um autocmd para garantir que o terminal esteja sempre no modo de inserção quando focado
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.cmd("startinsert")
	end,
})

-- Adiciona um autocmd para garantir que o terminal volte ao modo de inserção quando focado novamente
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "term://*",
	callback = function()
		vim.cmd("startinsert")
	end,
})

-- Mapeamento para abrir o SERPL em uma janela flutuante nativa
map("n", "<leader>fr", function()
    -- Cria uma janela flutuante
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)
    
    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        col = col,
        row = row,
        style = 'minimal',
        border = 'rounded'
    }
    
    local win = vim.api.nvim_open_win(buf, true, opts)
    
    -- Abre o SERPL no buffer
    vim.fn.termopen('serpl')
    
    -- Adiciona mapeamento para fechar com ESC
    vim.api.nvim_buf_set_keymap(buf, 't', '<Esc>', '<C-\\><C-n>:q!<CR>', 
        { noremap = true, silent = true, desc = "Close SERPL with ESC" })
    
    -- Entra no modo de inserção
    vim.cmd('startinsert')
end, { desc = "Open SERPL in floating window", noremap = true, silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
