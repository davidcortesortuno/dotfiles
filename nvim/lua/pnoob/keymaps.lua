local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Time Stamps with F6 (normal and insert mode)
keymap('n', '<F6>', '"=strftime("%c")<CR>P', opts)
keymap('i', '<F6>', '<C-R>=strftime("%c")<CR>', opts)

-- Remove trailing whitespaces with F5
keymap('n', '<F5>', "",  {
    -- silent = true,
    callback = function()
        -- Save cursor position to later restore
        local curpos = vim.api.nvim_win_get_cursor(0)
        -- Search and replace trailing whitespace
        vim.cmd([[keeppatterns %s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, curpos)
    end
})

-- Format paragraphs (ip --> internal paragraph) using Control Q
-- (it seems that C-Q is the equivalent to C-V, so redefine it)
keymap('n', '<C-Q>', 'gqip', opts)

-- Paste from the computer clipboard
keymap('', '<LocalLeader>p', '"+p', opts)
-- Yank to the computer clipboard
keymap('v', '<LocalLeader>y', '"+y', opts)

-- Disable arrow keys (ugh!)
keymap('n', '<Up>', '<NOP>', opts)
keymap('n', '<Down>', '<NOP>', opts)
keymap('n', '<Left>', '<NOP>', opts)
keymap('n', '<Right>', '<NOP>', opts)
