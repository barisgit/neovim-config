return {
  -- Bufferline/tabline
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup {
        options = {
          mode = "buffers", -- show buffers
          numbers = "ordinal", -- show buffer numbers
          diagnostics = "nvim_lsp", -- show LSP diagnostics
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and (vim.g.have_nerd_font and " " or "E")
                  or (e == "warning" and (vim.g.have_nerd_font and " " or "W")
                  or (vim.g.have_nerd_font and " " or "I"))
              s = s .. n .. sym
            end
            return s
          end,
          -- Use nvim-web-devicons if available
          show_buffer_icons = vim.g.have_nerd_font,
          show_buffer_close_icons = vim.g.have_nerd_font,
          separator_style = "thin", -- or 'slant'
        }
      }
    end,
  },
} 