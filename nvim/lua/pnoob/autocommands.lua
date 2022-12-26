vim.cmd [[
  augroup _simulation_files
    " OOMMFs .mif files syntax colouring as a .tcl file
    au BufRead,BufNewFile *.mif set filetype=tcl
    " MuMax3 files with Go syntax
    au BufRead,BufNewFile *.mx3 set filetype=go
  augroup end
]]
