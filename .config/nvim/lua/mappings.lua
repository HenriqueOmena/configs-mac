require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<M-BS>", "<C-w>", { desc = "Delete previous word in insert mode" })
map("n", "K", function()
  -- Exibe a mensagem de hover (informações do erro/warning)
  vim.lsp.buf.hover()

  -- Pega o diagnóstico da linha atual
  local diag = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })[1]
  if diag then
    -- Copia a mensagem para o clipboard
    vim.fn.setreg('+', diag.message)
    print("Copied diagnostic: " .. diag.message) -- Exibe uma confirmação
  end
end, { desc = "Show LSP hover and copy diagnostic" })

-- Terminal toggle
map("n", "<leader>tt", function()
  local term = require("toggleterm")
  term.toggle(1, nil, nil, "float")
  -- Força o foco no terminal e entra no modo de inserção
  vim.cmd("stopinsert")
  vim.defer_fn(function()
    vim.cmd("startinsert")
  end, 100)
end, { desc = "Toggle floating terminal", noremap = true, silent = true })

-- Adiciona um autocmd para garantir que o terminal esteja sempre no modo de inserção quando focado
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.cmd("startinsert")
  end
})

-- Adiciona um autocmd para garantir que o terminal volte ao modo de inserção quando focado novamente
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "term://*",
  callback = function()
    vim.cmd("startinsert")
  end
})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
