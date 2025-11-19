return {
  {
    'folke/snacks.nvim',
    dependencies = {
      'MaximilianLloyd/ascii.nvim',
    },
    priority = 1000,
    lazy = false,
    opts = function()
      local ascii = require 'ascii'
      return {
        dashboard = {
          enabled = true,
          sections = {
            { section = 'header' },
            { section = 'keys', gap = 1, padding = 1 },
            { section = 'startup' },
          },
          preset = {
            keys = {
              { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
              { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
              { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
              { icon = ' ', key = 'w', desc = 'Find Word', action = ":lua Snacks.dashboard.pick('grep_string')" },
              { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
              { icon = ' ', key = 'b', desc = 'Buffers', action = ":lua Snacks.dashboard.pick('buffers')" },
              { icon = ' ', key = 'gs', desc = 'Git Status', action = ":lua Snacks.dashboard.pick('git_status')" },
              { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
              { icon = ' ', key = 'h', desc = 'Help Tags', action = ":lua Snacks.dashboard.pick('help_tags')" },
              { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
              { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
            },
            header = table.concat(ascii.art.text.neovim.sharp, '\n'),
          },
        },
      }
    end,
  },
}
