-- lua/custom/plugins/codeium.lua
return {
    "Exafunction/codeium.nvim",
    cond = not vim.g.vscode,
    event = "InsertEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    keys = {
        { '<leader>aX', '<cmd>Codeium Toggle<cr>', desc = 'Toggle Codeium' },
        { '<leader>ao', '<cmd>Codeium Chat<cr>', desc = 'Open Codeium Chat' },
        { '<leader>aA', '<cmd>Codeium Auth<cr>', desc = 'Authenticate Codeium' },
    },
    config = function()
        require("codeium").setup({
            -- Enable both cmp source and inline suggestions (virtual text)
            enable_cmp_source = true,
            virtual_text = {
                enabled = true, -- Set to true for inline suggestions
                -- Default keybindings:
                -- <Tab> - Accept completion
                -- <M-]> (Alt+]) - Next completion
                -- <M-[> (Alt+[) - Previous completion
            },
        })
    end,
}
