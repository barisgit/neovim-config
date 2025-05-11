-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  cond = not vim.g.vscode,
  branch = "v3.x",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    sources = {
      "filesystem",
      "buffers",
    },
    filesystem = {
      window = {
        mappings = {
          ['o'] = 'open_vsplit',
          ['O'] = 'open_split',
          ['s'] = 'noop',
          ['S'] = 'noop',
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
