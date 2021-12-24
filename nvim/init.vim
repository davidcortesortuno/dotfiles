call plug#begin('~/.nvim/plugged')

" Make sure you use single quotes
"
Plug 'mhartington/oceanic-next'
Plug 'morhetz/gruvbox'
Plug 'lervag/vimtex'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'neomake/neomake'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround'

Plug 'neovim/nvim-lspconfig'
" Install language servers automatically:
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
" For vsnip users.
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

" Add plugins to &runtimepath
call plug#end()

" Theme ----------------------------------------------------------------------
set background=dark

" "" For Neovim 0.1.3 and 0.1.4
" let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 0
"
" " Or if you have Neovim >= 0.1.5
" if (has("termguicolors"))
"  set termguicolors
" endif
"
syntax enable
" colorscheme OceanicNext
colorscheme gruvbox

filetype indent plugin on

" cmp -------------------------------------------------------------------------

set completeopt=menu,menuone,noselect

lua <<EOF

  -- Setup luasnip -----------------------------------------------------------
  local luasnip = require('luasnip')
  -- snippets from json files
  require("luasnip.loaders.from_vscode").lazy_load()
  luasnip.filetype_set("cu", { "c", "cpp" })
  -- print(cmp.core.sources)

  -- lsp setting -------------------------------------------------------------
  local nvim_lsp = require('lspconfig')

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local my_custom_on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  end

  -- Setup nvim-cmp. ---------------------------------------------------------
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Setup lspconfig.
  -- nvim-cmp supports additional completion capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  -- lsp installer
  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local opts = {
    	on_attach = my_custom_on_attach,
    	capabilities = capabilities,
    }

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end
    if server.name == "pyright" then
        -- print(opts.filetypes)
        -- opts.filetypes.python = "flake8"
    end

    -- if server.name == "diagnosticls" then
    --   opts.settings = {
    --     filetypes = { python = {"flake8"} },
    --     linters = {
    --       flake8 = {
    --         debounce = 100,
    --         sourceName = "flake8",
    --         command = "flake8",
    --         args = {
    --           "--format",
    --           "%(row)d:%(col)d:%(code)s:%(code)s: %(text)s",
    --           "%file",
    --         },
    --         formatPattern = {
    --           "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
    --           {
    --               line = 1,
    --               column = 2,
    --               message = {"[", 3, "] ", 5},
    --               security = 4
    --           }
    --         },
    --         securities = {
    --           E = "error",
    --           W = "warning",
    --           F = "info",
    --           B = "hint",
    --         },
    --       },
    --     }
    --   }
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function
    -- (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
  end)

  -- Set completeopt to have a better completion experience
  vim.o.completeopt = 'menuone,noselect'

  -- null-ls configuration:
  require("null-ls").setup({
      -- you must define at least one source for the plugin to work
      sources = { 
          require("null-ls").builtins.diagnostics.flake8 
      },
      on_attach = my_custom_on_attach
  })
  -- nvim_lsp["null-ls"].setup({
  --     -- see the nvim-lspconfig documentation for available configuration options
  --     on_attach = my_custom_on_attach
  -- })

  -- Avoid diagnostic messages inline -> Use space+e
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  	vim.lsp.diagnostic.on_publish_diagnostics, {
  	  virtual_text = false,
  	  underline = true,
	  signs = true,
  	}
  )

  vim.cmd [[autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()]]
  vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

EOF

" airline --------------------------------------------------------------------

set laststatus=2
" let g:airline_theme             = 'gruvbox'
let g:airline_theme             = 'molokai'
let g:airline_enable_branch     = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#coc#enabled = 1

set encoding=utf-8

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

" Underline for spell
hi clear SpellBad
hi SpellBad cterm=underline

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
"  vimTeX
let g:tex_flavor = 'latex'
