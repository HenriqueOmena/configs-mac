-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@class ChadrcConfig
local M = {}

M.ui = {
  telescope = {
    style = "borderless",            -- borderless / bordered
    defaults = {
      path_display = { "truncate" }, -- Aplica o truncate para todos os caminhos no Telescope
    },
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    StatuslineFile = { fg = "#FF8800", bg = "#000000", bold = true }, -- Define as cores para o texto
  },
  statusline = {
    theme = "default",                                                                   -- Altere o tema aqui conforme desejado, como "default", "vscode", "minimal"
    separator_style = "default",                                                         -- O estilo do separador (round, block, etc.)
    order = { "mode", "f", "git", "diagnostics", "%=", "lsp_msg", "%=", "lsp", "cwd", }, -- Ordem dos módulos na statusline
    modules = {
      f = function()
        local path = vim.fn.expand("%:f")         -- Caminho relativo
        -- print("Statusline file:", "%#StatuslineFile#") -- Debug
        return "%#StatuslineFile#" .. path .. " " -- Associa ao grupo de destaque
      end,                                        -- Mostra o caminho do arquivo
    },
  }
}

M.base46 = {
  theme = "onedark",
}

return M
