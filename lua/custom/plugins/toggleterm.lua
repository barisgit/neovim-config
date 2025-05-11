return {
    -- Add persistent terminal
    'akinsho/toggleterm.nvim',
    version = '*', -- or version = "v2.7.0" if you know the version you want
    cond = not vim.g.vscode,
    config = function()
        require('toggleterm').setup {
            -- size can be a number or function which is passed the current terminal
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<c-t>]],
            hide_numbers = true, -- hide the number column in toggleterm buffers
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,   -- whether or not the open mapping applies in insert mode
            terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
            persist_size = true,
            direction = 'float',      -- 'vertical' | 'horizontal' | 'tab' | 'float'
            close_on_exit = true,     -- close the terminal window when the process exits
            shell = vim.o.shell,      -- change the default shell
            float_opts = {
                -- The border key is *almost* the same as 'nvim_open_win'
                -- see :h nvim_open_win for details on borders however
                -- the 'curved' border is a custom border type
                -- not natively supported but implemented in this plugin.
                border = 'curved', -- 'single' | 'double' | 'shadow' | 'curved' |
                -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
                -- width = <value>,
                -- height = <value>,
                winblend = 0,
                highlights = {
                    border = 'Normal',
                    background = 'Normal',
                },
            },
        }

        function _G.set_terminal_keymaps()
            local opts = { noremap = true }
            vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd 'autocmd! TermOpen term://* lua set_terminal_keymaps()'

        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new { cmd = 'lazygit', hidden = true, direction = 'float' }

        _G._LAZYGIT_TOGGLE = function()
            lazygit:toggle()
        end
        vim.keymap.set('n', '<leader>tl', '<cmd>lua _G._LAZYGIT_TOGGLE()<CR>',
            { noremap = true, silent = true, desc = 'Toggle [L]azyGit' })
    end,
}
