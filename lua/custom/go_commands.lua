-- Custom Go commands
local Terminal = require('toggleterm.terminal').Terminal

local function get_current_file_parent_dir()
    local current_file_full_path = vim.fn.expand('%:p')
    if not current_file_full_path or current_file_full_path == '' then
        vim.notify("No file open to determine parent directory.", vim.log.levels.WARN, { title = "Go Command" })
        return nil
    end

    if vim.fn.isdirectory(current_file_full_path) == 1 then
        vim.notify("Current buffer is a directory. Open a file within the Go project.", vim.log.levels.WARN,
            { title = "Go Command" })
        return nil
    end

    local parent_dir = vim.fn.fnamemodify(current_file_full_path, ':h')
    if not parent_dir or parent_dir == '' or parent_dir == '.' then
        vim.notify("Could not determine parent directory for: " .. current_file_full_path, vim.log.levels.WARN,
            { title = "Go Command" })
        return nil
    end
    return parent_dir
end

local function run_go_command_in_parent_dir(subcommand, notification_verb)
    local parent_dir = get_current_file_parent_dir()
    if not parent_dir then
        return
    end

    local cmd_to_run = 'cd ' .. vim.fn.shellescape(parent_dir) .. ' && go ' .. subcommand .. ' .'
    local title = "Go " .. subcommand:sub(1, 1):upper() .. subcommand:sub(2)

    local go_term = Terminal:new({
        cmd = cmd_to_run,
        direction = 'float',
        close_on_exit = false,
        float_opts = {
            border = 'curved',
            winblend = 0,
        },
        on_open = function(term)
            if term.window and vim.api.nvim_win_is_valid(term.window) then
                vim.api.nvim_set_current_win(term.window)
            end
            vim.cmd 'startinsert!'
            vim.notify((notification_verb or "Running") .. ": " .. cmd_to_run, vim.log.levels.INFO, { title = title })
            vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<C-x>', '<cmd>close<CR>',
                { noremap = true, silent = true, desc = "Close Go terminal" })
            vim.api.nvim_buf_set_keymap(term.bufnr, 't', '<Esc><Esc>', '<C-\\><C-n><cmd>close<CR>',
                { noremap = true, silent = true, desc = "Exit terminal mode and close" })
        end,
        on_close = function(_term)
            vim.notify("Go " .. subcommand .. " command finished.", vim.log.levels.INFO, { title = title })
        end,
        auto_scroll = true,
        hidden = false,
    })
    go_term:toggle()
end

_G.GO_RUN_COMMAND = function()
    run_go_command_in_parent_dir("run", "Running")
end

_G.GO_TEST_COMMAND = function()
    run_go_command_in_parent_dir("test", "Testing")
end

_G.GO_BUILD_COMMAND = function()
    run_go_command_in_parent_dir("build", "Building")
end

vim.keymap.set('n', '<leader>lgr', '<cmd>lua _G.GO_RUN_COMMAND()<CR>',
    { noremap = true, silent = true, desc = 'Go [R]un . (in parent dir)' })

vim.keymap.set('n', '<leader>lgt', '<cmd>lua _G.GO_TEST_COMMAND()<CR>',
    { noremap = true, silent = true, desc = 'Go [T]est . (in parent dir)' })

vim.keymap.set('n', '<leader>lgb', '<cmd>lua _G.GO_BUILD_COMMAND()<CR>',
    { noremap = true, silent = true, desc = 'Go [B]uild . (in parent dir)' })
