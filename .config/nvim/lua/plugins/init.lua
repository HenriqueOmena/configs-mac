return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

	{
		"nvim-lua/plenary.nvim",
		lazy = true, -- Carregar apenas quando necessário
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		opts = require("configs.conform"),
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"yaml",
				"markdown",
				"markdown_inline",
				"bash",
				"regex",
			},
		},
	},

	{
		"kdheepak/lazygit.nvim",
		lazy = false,
		config = function()
			vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true }) -- Atalho para abrir o LazyGit
		end,
	},

	-- Adiciona o plugin toggleterm
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
				-- Adiciona esta opção para melhorar a experiência de alternância
				on_open = function(term)
					vim.cmd("startinsert!")
				end,
				on_close = function(term)
					vim.cmd("stopinsert")
				end,
			})

			-- Configuração para o serpl (busca e substituição)
			local Terminal = require("toggleterm.terminal").Terminal
			local serpl = Terminal:new({
				cmd = "serpl",
				hidden = true,
				direction = "float",
				float_opts = {
					border = "curved",
				},
			})

			-- Função para abrir o serpl
			function _SERPL_TOGGLE()
				serpl:toggle()
			end

			-- Atalho 'fr' para busca e substituição com serpl
			vim.api.nvim_set_keymap("n", "fr", "<cmd>lua _SERPL_TOGGLE()<CR>", { noremap = true, silent = true })
			vim.api.nvim_set_keymap("v", "fr", "<cmd>lua _SERPL_TOGGLE()<CR>", { noremap = true, silent = true })
		end,
	},

}
