return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    on_attach = function(bufnr)
      local api = require('nvim-tree.api')

      -- Helper function to set keymaps
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      -- Personalizados
      vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
      vim.keymap.set("n", "l", api.node.open.edit, opts("Open File or Folder"))

      -- Reaplicar comportamento padrão do Enter
      vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open File or Folder (default)"))

      -- Reativar o comportamento padrão do mouse
      vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open File or Folder with Mouse"))
      vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("Change Root with Mouse"))
    end,
    view = {
      side = "left",
      width = 50,
    },
    renderer = {
      icons = {
        show = {
          file = true,
          folder = false,
          folder_arrow = true,
        },
      },
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
