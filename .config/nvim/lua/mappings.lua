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


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
