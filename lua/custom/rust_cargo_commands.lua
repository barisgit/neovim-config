-- Custom Cargo commands for Rust projects
local function find_cargo_root()
  local base_search_path
  local current_file_full_path = vim.fn.expand '%:p' -- Might be CWD if buffer is empty

  if vim.fn.filereadable(current_file_full_path) == 1 then -- It's a file
    base_search_path = vim.fn.fnamemodify(current_file_full_path, ':h')
  elseif vim.fn.isdirectory(current_file_full_path) == 1 then -- It's a directory (e.g. netrw, Neo-tree focus, or CWD for empty buffer)
    base_search_path = current_file_full_path
  else -- Should ideally be covered by the above, but as a final fallback
    base_search_path = vim.fn.getcwd()
  end

  if not base_search_path or base_search_path == '' then
    vim.notify('Could not determine a valid starting directory for Cargo project search.', vim.log.levels.WARN, { title = 'Cargo' })
    return nil
  end

  local path_to_check = base_search_path
  -- Loop for Cargo.toml
  for _ = 1, 3 do -- Check path_to_check, its parent, its grandparent
    if vim.fn.filereadable(path_to_check .. '/Cargo.toml') == 1 then
      return path_to_check
    end
    local parent = vim.fn.fnamemodify(path_to_check, ':h')
    if parent == path_to_check or parent == '' then -- Reached filesystem root or invalid path
      break
    end
    path_to_check = parent
  end

  vim.notify("Cargo.toml not found in '" .. base_search_path .. "' or its two direct parent directories.", vim.log.levels.INFO, { title = 'Cargo' })
  return nil
end

local function run_cargo_command(command)
  local cargo_root = find_cargo_root()
  if not cargo_root then
    return
  end

  local Terminal = require('toggleterm.terminal').Terminal
  local cmd_to_run = 'cd ' .. vim.fn.shellescape(cargo_root) .. ' && cargo ' .. command

  local term = Terminal:new {
    cmd = cmd_to_run,
    direction = 'float',
    close_on_exit = false, -- Keep terminal open after command finishes
    float_opts = {
      border = 'curved',
      winblend = 0,
    },
    on_open = function(t)
      -- Ensure the terminal window is focused and in insert mode.
      -- Note: toggleterm might handle focus automatically with `startinsert!`.
      -- Forcing focus via nvim_win_set_buf can be helpful.
      if t.window and vim.api.nvim_win_is_valid(t.window) then
        vim.api.nvim_set_current_win(t.window)
      end
      vim.cmd 'startinsert!'
    end,
    on_close = function()
      vim.notify('Cargo ' .. command .. ' finished.', vim.log.levels.INFO, { title = 'Cargo' })
    end,
    auto_scroll = true, -- Keep scrolled to the bottom
    hidden = false, -- Setting to false ensures it tries to open, cmd runs on new.
    -- toggle() will then manage visibility.
  }
  term:toggle()
end

_G.RUST_CARGO_RUN = function()
  run_cargo_command 'run'
end

_G.RUST_CARGO_CHECK = function()
  run_cargo_command 'check'
end

_G.RUST_CARGO_DOC = function()
  run_cargo_command 'doc --open'
end

vim.keymap.set('n', '<leader>lrr', '<cmd>lua _G.RUST_CARGO_RUN()<CR>', { noremap = true, silent = true, desc = 'Cargo [R]un' })
vim.keymap.set('n', '<leader>lrc', '<cmd>lua _G.RUST_CARGO_CHECK()<CR>', { noremap = true, silent = true, desc = 'Cargo [C]heck' })
vim.keymap.set('n', '<leader>lrd', '<cmd>lua _G.RUST_CARGO_DOC()<CR>', { noremap = true, silent = true, desc = 'Cargo [D]oc' })
