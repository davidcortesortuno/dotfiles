-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.cmd [[
  augroup _simulation_files
    " OOMMFs .mif files syntax colouring as a .tcl file
    au BufRead,BufNewFile *.mif set filetype=tcl
    " MuMax3 files with Go syntax
    au BufRead,BufNewFile *.mx3 set filetype=go
  augroup end
]]
