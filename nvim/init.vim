" Use Packer to start plugins
lua require('pnoob.options')
lua require('pnoob.keymaps')
lua require('pnoob.plugins')
lua require('pnoob.colorscheme')
lua require('pnoob.spellsitter')
lua require('pnoob.treesitter')
lua require('pnoob.cmp')
lua require('pnoob.lsp')
lua require('pnoob.diagnostic')
lua require('pnoob.lualine')
lua require('pnoob.nvim-tree')
lua require('pnoob.autocommands')

" filetype indent plugin on

" ----------------------------------------------------------------------------



" Fill the rest of a line with characters ------------------------------------
function! FillLine( str )
    " set tw to the desired total length
    let tw = &textwidth
    if tw==0 | let tw = 79 | endif
    " echo tw
    " strip trailing spaces first
    .s/[[:space:]]*$//
    " calculate total number of 'str's to insert
    let reps = (tw - col("$")) / len(a:str)
    " insert them, if there's room, removing trailing spaces (though forcing
    " there to be one)
    " echo reps
    if reps > 0
        .s/$/\=(' '.repeat(a:str, reps))/
    endif
endfunction

" Assign a map to this function
map <F3> :call FillLine( '-' )
