-- lua/custom/plugins/codeium.lua
return {
    "Exafunction/codeium.nvim",
    cond = not vim.g.vscode,
    event = "InsertEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
            -- Enable both cmp source and inline suggestions (virtual text)
            enable_cmp_source = true,
            virtual_text = {
                enabled = true, -- Set to true for inline suggestions
                -- You can customize keybindings and filetypes here if desired
            },
        })
    end,
}
