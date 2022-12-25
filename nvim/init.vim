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

" Theme ----------------------------------------------------------------------
" set background=dark
" syntax enable
" colorscheme gruvbox
colorscheme kanagawa

filetype indent plugin on

lua << EOF

  -- This assumes `ccls` exists on path
  -- nvim_lsp.ccls.setup {
  --   on_attach = my_custom_on_attach,
  --   capabilities = capabilities,
  --   filetypes = {"c", "cpp"},
  --   init_options = {
  --     cache = {
  --       directory = ".ccls-cache";
  --     };
  --   }
  -- }


EOF

" airline --------------------------------------------------------------------

" set laststatus=2
" " let g:airline_theme           = 'gruvbox'
" let g:airline_theme             = 'molokai'
" let g:airline_enable_branch     = 1
" let g:airline_powerline_fonts = 1
" let g:airline#extensions#coc#enabled = 1
" 
" set encoding=utf-8

" ----------------------------------------------------------------------------

" Time Stamps with F6
nnoremap <F6> "=strftime("%c")<CR>P
inoremap <F6> <C-R>=strftime("%c")<CR>

" Numbers for lines
set number

" Remove trailing whitespaces with F5
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Use spaces
set expandtab
" make *tab* insert indents instead of tabs at the beginning of a line
" set smarttab
" size of a hard tabstop
set tabstop=4
set softtabstop=4
" Size of an *indent*
set shiftwidth=4
" Fix column of warning/error signs
set signcolumn=yes:1

" Set directory to the location of the edited file
set autochdir

" Highlight characters beyond the 79th position in a line
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%80v.\+/
set colorcolumn=80

" OOMMFs .mif files syntax colouring as a .tcl file
au BufRead,BufNewFile *.mif set filetype=tcl
" MuMax3 files with Go syntax
au BufRead,BufNewFile *.mx3 set filetype=go

" Guide lines for identation
" let g:indent_guides_guide_size = 1

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

" ----------------------------------------------------------------------------

" Format paragraphs (ip --> internal paragraph) using Control Q
" (it seems that C-Q is the equivalent to C-V, so redefine it)
nnoremap <C-Q> gqip

" Paste from the computer clipboard
noremap <LocalLeader>p "+p
" Yank to the computer clipboard
vnoremap <LocalLeader>y "+y

" Insert blank line in visual mode with Enter and Shift-Enter
nnoremap <Enter> :call append(line('.'), '')<CR>
nnoremap <S-Enter> :call append(line('.')-1, '')<CR>

" Disable arrow keys (ugh!)
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Riv (for RST files): avoid folding
" let g:riv_disable_folding = 1

" ----------------------------------------------------------------------------
