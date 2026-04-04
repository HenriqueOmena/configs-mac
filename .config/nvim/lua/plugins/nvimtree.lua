return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")

			-- Helper function to set keymaps
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Mapeamentos personalizados (navegação estilo vim)
			vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
			vim.keymap.set("n", "l", api.node.open.edit, opts("Open File or Folder"))
			vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "v", api.node.open.vertical, opts("Open in Vertical Split"))
			vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open in Horizontal Split"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
		end,

		-- Configurações de visualização
		view = {
			side = "left",
			width = 40, -- Largura da janela (ajuste se necessário)
			adaptive_size = true, -- Ajusta automaticamente conforme o conteúdo
		},

		-- Renderização (AQUI ESTÁ O IMPORTANTE - ÍCONES E NOMES)
		renderer = {
			-- Indentação para hierarquia de pastas
			indent_markers = {
				enable = true, -- Mostra linhas de indentação
				icons = {
					corner = "└",
					edge = "│",
					item = "├",
					none = " ",
				},
			},

			-- Ícones de arquivos e pastas
			icons = {
				show = {
					file = true, -- Mostra ícones de arquivo
					folder = true, -- Mostra ícones de pasta
					folder_arrow = true, -- Mostra seta para expandir pasta
					git = true, -- Mostra status do git
				},
				glyphs = {
					default = "", -- Ícone padrão para arquivo
					symlink = "",
					folder = {
						arrow_closed = "▶",
						arrow_open = "▼",
						default = "",
						open = "",
						empty = "",
						empty_open = "",
						symlink = "",
						symlink_open = "",
					},
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➡",
						untracked = "★",
						deleted = "",
						ignored = "○",
					},
				},
			},

			-- Mostra nomes completos dos arquivos
			root_folder_label = ":~:s?$?/..?", -- Mostra path relativo
			highlight_git = true,
			highlight_opened_files = "name", -- Destaca arquivos abertos
		},

		-- Filtros (arquivos/pastas ocultos)
		filters = {
			dotfiles = false, -- Mostra arquivos ocultos (.gitignore, .env, etc)
			custom = { ".DS_Store", "node_modules", ".git" }, -- Oculta esses
		},

		-- Comportamento ao abrir arquivos
		actions = {
			open_file = {
				quit_on_open = false, -- Não fecha o tree ao abrir arquivo
				resize_window = true, -- Ajusta tamanho da janela
			},
		},

		-- Integração com Git
		git = {
			enable = true,
			ignore = false, -- Mostra arquivos ignorados pelo git
		},
	},

	config = function(_, opts)
		-- Desabilita netrw (file explorer padrão do vim)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		require("nvim-tree").setup(opts)
	end,
}
