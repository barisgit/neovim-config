-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'n'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

vim.opt.tabstop = 4    -- Number of visual spaces per tab
vim.opt.shiftwidth = 4 -- Number of spaces for autoindent

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Buffer navigation and management
vim.keymap.set('n', '<leader>un', '<cmd>bnext<CR>', { desc = '[U]se buffer [N]ext' })
vim.keymap.set('n', '<leader>up', '<cmd>bprev<CR>', { desc = '[U]se buffer [P]revious' })
vim.keymap.set('n', '<leader>ud', '<cmd>bdelete<CR>', { desc = '[U]se buffer [D]elete' })
vim.keymap.set('n', '<leader>ul', '<cmd>Telescope buffers<CR>', { desc = '[U]se buffer [L]ist (Telescope)' })

-- Split and buffer combinations
vim.keymap.set('n', '<leader>uv', '<cmd>vsplit | bnext<CR>', { desc = '[U]se buffer [V]ertical split next' })
vim.keymap.set('n', '<leader>us', '<cmd>split | bnext<CR>', { desc = '[U]se buffer [S]plit next' })

-- Save keybindings
-- Cmd+S in iTerm2: Preferences > Profiles > Keys > + > Cmd+S > Send Hex Code: 13
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { noremap = true, silent = true, desc = 'Save file' })
vim.keymap.set('i', '<C-s>', '<Esc><cmd>w<CR>', { noremap = true, silent = true, desc = 'Save file' })
vim.keymap.set('n', '<C-S-s>', '<cmd>wa<CR>', { noremap = true, silent = true, desc = 'Save all buffers' })
vim.keymap.set('i', '<C-S-s>', '<Esc><cmd>wa<CR>', { noremap = true, silent = true, desc = 'Save all buffers' })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { noremap = true, silent = true, desc = 'Save file' })
vim.keymap.set('n', '<leader>W', '<cmd>wa<CR>', { noremap = true, silent = true, desc = 'Save all buffers' })

-- Auto open Neo-tree on startup
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Open Neo-tree on startup',
  group = vim.api.nvim_create_augroup('UserNeoTree', { clear = true }),
  callback = function()
    vim.cmd 'Neotree filesystem left reveal'
  end,
})

-- Custom Keymaps for Trouble (globally defined after plugins load) -- TODO: Some of these are not working
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics<CR>', { desc = 'Toggle Trouble' })
vim.keymap.set('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<CR>', { desc = 'Workspace Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xd', '<cmd>Trouble document_diagnostics<CR>', { desc = 'Document Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xl', '<cmd>Trouble loclist<CR>', { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble quickfix<CR>', { desc = 'Quickfix List (Trouble)' })
vim.keymap.set('n', '<leader>xr', '<cmd>Trouble lsp_references<CR>', { desc = 'LSP References (Trouble)' })
vim.keymap.set('n', '<leader>xt', '<cmd>Trouble lsp_type_definitions<CR>', { desc = 'LSP Type Definitions (Trouble)' })
vim.keymap.set('n', '<leader>xT', '<cmd>Trouble todo<CR>', { desc = 'Todo (Trouble)' })
