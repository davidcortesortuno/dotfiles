-- Disable nvim's file manager netrw at the very start of your init.lua
-- for nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'
-- vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.spell = true
vim.opt.spelllang = { 'en_gb' }

local options = {
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  pumheight = 10,                          -- pop up menu height
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  -- timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  -- updatetime = 300,                        -- faster completion (4000ms default)
  -- writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 4,                          -- the number of spaces inserted for each indentation
  -- softtabstop = 4
  tabstop = 4,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = false,                  -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}

  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  -- wrap = true,                             -- display lines as one long line
  -- linebreak = true,                        -- companion to wrap, don't split words
  -- scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
  -- sidescrolloff = 8,                       -- minimal number of screen columns either side of cursor if wrap is `false`
  whichwrap = "bs<>[]hl",                  -- which "horizontal" keys are allowed to travel to prev/next line
  colorcolumn = "80",
  autochdir = true,
}

-- Apply the options from the list above
for k, v in pairs(options) do
  vim.opt[k] = v
end
