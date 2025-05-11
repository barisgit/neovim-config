return {
    -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
        --  - ci'  - [C]hange [I]nside [']quote
        require('mini.ai').setup { n_lines = 500 }

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        -- - sd'   - [S]urround [D]elete [']quotes
        -- - sr)'  - [S]urround [R]eplace [)] ['_]
        -- require('mini.surround').setup()

        -- Simple and easy statusline.
        local statusline = require 'mini.statusline'
        statusline.setup {
            use_icons = vim.g.have_nerd_font,
            content = {
                active = function()
                    local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
                    local filename = vim.g.vscode and '' or
                        statusline.section_filename { trunc_width = 140, file_readonly = true, file_modified = true }
                    local git = statusline.section_git { trunc_width = 75, diff = true } -- Assuming diff = true is a valid arg or handled by mini.git
                    local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
                    local lsp = statusline.section_lsp { trunc_width = 75 }
                    local location = statusline.section_location { trunc_width = 75 }
                    local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
                    local codeium_status_fn = function()
                        if vim.g.vscode then
                            return ''
                        end

                        local vt_ok, vt_module = pcall(require, 'codeium.virtual_text')
                        if not vt_ok or vt_module == nil then
                            return 'Codeium: NoVTMod' -- Debug: codeium.virtual_text module not found or require failed
                        end

                        local status_ok, status_str = pcall(vt_module.status_string)
                        if not status_ok then
                            return 'Codeium: ErrVTCall' -- Debug: error calling status_string
                        end
                        if status_str == nil then
                            return 'Codeium: NilVTStr' -- Debug: status_string returned nil
                        end
                        if status_str == '' then
                            return 'Codeium: EmptyVTStr' -- Debug: status_string returned an empty string
                        end

                        if status_str == '*' then
                            return 'Codeium: Wait'
                        elseif status_str == '0' then
                            return 'Codeium: No Sugg'
                        elseif string.match(status_str, '^%d+/%d+$') then
                            return 'Codeium: ' .. status_str
                        else
                            -- Capture the actual unexpected string for better debugging
                            return 'Codeium: UnkVT-' .. tostring(status_str)
                        end
                    end
                    local codeium_status = codeium_status_fn()

                    return statusline.combine_groups {
                        { hl = mode_hl,                 strings = { mode } },
                        { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics, lsp, codeium_status } },
                        '%<', -- Mark general truncate point
                        { hl = 'MiniStatuslineFilename', strings = { filename } },
                        '%=', -- End left alignment
                        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
                        { hl = mode_hl,                  strings = { location } },
                    }
                end,
                inactive = function()
                    -- For inactive, just filename, ensuring it's called with an args table
                    return statusline.section_filename { trunc_width = 140 }
                end,
            },
        }

        -- You can configure sections in the statusline by overriding their
        -- default behavior. For example, here we set the section for
        -- cursor location to LINE:COLUMN
        ---@diagnostic disable-next-line: duplicate-set-field
        statusline.section_location = function()
            if not vim.g.vscode then
                return '%2l:%-2v'
            else
                return ''
            end
        end

        -- mini.indentscope setup
        require('mini.indentscope').setup {
            -- No specific options needed for default setup, {} is fine
            -- Or you can explore its options later:
            -- symbol = '|',
            -- options = { try_as_border = true },
        }

        if not vim.g.vscode then
            require('mini.animate').setup({
                scroll = {
                    enable = false, -- If you still use mouse to scroll, this gets janky
                }
            })
        end
    end,
}
