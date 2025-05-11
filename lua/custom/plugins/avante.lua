return {
    'yetone/avante.nvim',
    cond = not vim.g.vscode,
    event = 'VeryLazy',
    version = false, -- Never set this value to "*"! Never!
    opts = {
        -- add any opts here
        -- for example
        provider = 'gemini',
        cursor_applying_provider = 'groq_applying', -- In this example, use Groq for applying, but you can also use any provider you want.
        auto_suggestions_provider = 'groq',         -- Use Groq for auto-suggestions
        behaviour = {
            --- ... existing behaviours
            auto_suggestions = false,           -- Disable auto-suggestions
            enable_cursor_planning_mode = true, -- enable cursor planning mode!
        },
        gemini = {
            model = 'gemini-2.5-flash-preview-04-17',
            max_tokens = 8192,
            temperature = 0,
            timeout = 30000,
            --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
        vendors = {
            --- ... existing vendors
            groq_applying = { -- define groq provider
                __inherited_from = 'openai',
                api_key_name = 'GROQ_API_KEY',
                endpoint = 'https://api.groq.com/openai/v1/',
                model = 'llama-3.1-8b-instant',
                max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
            },
            groq = {                           -- define groq provider
                __inherited_from = 'openai',
                api_key_name = 'GROQ_API_KEY',
                endpoint = 'https://api.groq.com/openai/v1/',
                model = 'llama-3.1-8b-instant',
                max_completion_tokens = 512, -- remember to increase this value, otherwise it will stop generating halfway
            },
        },
        mappings = {
            suggestion = {
                accept = '<C-Enter>', -- Or any other key you prefer
            },
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'stevearc/dressing.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        --- The below dependencies are optional,
        'echasnovski/mini.pick',         -- for file_selector provider mini.pick
        'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
        'hrsh7th/nvim-cmp',              -- autocompletion for avante commands and mentions
        'ibhagwan/fzf-lua',              -- for file_selector provider fzf
        'nvim-tree/nvim-web-devicons',   -- or echasnovski/mini.icons
        {
            -- support for image pasting
            'HakonHarnes/img-clip.nvim',
            event = 'VeryLazy',
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { 'markdown', 'Avante' },
            },
            ft = { 'markdown', 'Avante' },
        },
    },
}
