-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@class ChadrcConfig
local M = {}

M.ui = {
	telescope = {
		style = "borderless", -- borderless / bordered
		defaults = {
			path_display = { "truncate" }, -- Aplica o truncate para todos os caminhos no Telescope
			file_sorter = require("telescope.sorters").get_fzy_sorter,
			file_ignore_patterns = {}, -- Não ignora nada, apenas reordena
		},
		pickers = {
			live_grep = {
				-- Função customizada para ordenar resultados
				sorter = require("telescope.sorters").get_generic_fuzzy_sorter({}),
				-- Adiciona peso menor para imagens
				entry_maker = function(entry)
					local make_entry = require("telescope.make_entry")
					local result = make_entry.gen_from_vimgrep()(entry)
					
					if result then
						local filename = result.filename or ""
						-- Verifica se é imagem
						if filename:match("%.(png|jpg|jpeg|gif|svg|webp|ico|bmp)$") then
							result.ordinal = "zzz_" .. result.ordinal -- Adiciona prefixo para ordenar por último
						end
					end
					
					return result
				end,
			},
			find_files = {
				-- Também aplica ao find_files
				entry_maker = function(entry)
					local make_entry = require("telescope.make_entry")
					local result = make_entry.gen_from_file()(entry)
					
					if result and result.ordinal then
						if result.ordinal:match("%.(png|jpg|jpeg|gif|svg|webp|ico|bmp)$") then
							result.ordinal = "zzz_" .. result.ordinal
						end
					end
					
					return result
				end,
			},
		},
	},

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
		StatuslineFile = { fg = "#FF8800", bg = "#000000", bold = true }, -- Define as cores para o texto
	},
	statusline = {
		theme = "default", -- Altere o tema aqui conforme desejado, como "default", "vscode", "minimal"
		separator_style = "default", -- O estilo do separador (round, block, etc.)
		order = { "mode", "f", "git", "diagnostics", "%=", "lsp_msg", "%=", "lsp", "cwd" }, -- Ordem dos módulos na statusline
		modules = {
			f = function()
				local path = vim.fn.expand("%:f") -- Caminho relativo
				-- print("Statusline file:", "%#StatuslineFile#") -- Debug
				return "%#StatuslineFile#" .. path .. " " -- Associa ao grupo de destaque
			end, -- Mostra o caminho do arquivo
		},
	},
}

M.base46 = {
	theme = "onedark",
}

return M
