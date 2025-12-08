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

-- Busca agrupada por arquivo com contagem de matches
map("n", "<leader>fG", function()
	local pickers = require("telescope.pickers")
	local finders = require("telescope.finders")
	local conf = require("telescope.config").values
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")

	-- Pede o termo de busca
	local search_term = vim.fn.input("Grep > ")
	if search_term == "" then
		return
	end

	-- Executa rg para contar matches por arquivo
	local cmd = string.format("rg --count --color never '%s' 2>/dev/null", search_term)
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()

	-- Processa os resultados
	local files = {}
	for line in result:gmatch("[^\n]+") do
		local file, count = line:match("^(.+):(%d+)$")
		if file and count then
			table.insert(files, {
				filename = file,
				count = tonumber(count),
				display = string.format("%s (%d matches)", file, count),
			})
		end
	end

	-- Ordena por quantidade de matches (maior primeiro)
	table.sort(files, function(a, b)
		return a.count > b.count
	end)

	-- Cria o picker
	pickers
		.new({}, {
			prompt_title = "Grep por Arquivo (" .. search_term .. ")",
			finder = finders.new_table({
				results = files,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry.display,
						ordinal = entry.display,
						filename = entry.filename,
					}
				end,
			}),
			sorter = conf.generic_sorter({}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					vim.cmd("edit " .. selection.filename)
				end)
				return true
			end,
		})
		:find()
end, { desc = "Grep agrupado por arquivo com contagem" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
