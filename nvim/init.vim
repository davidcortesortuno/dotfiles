call plug#begin('~/.nvim/plugged')

" Make sure you use single quotes

" Colorschemes
" Gruvbox with tree-sitter support
Plug 'ellisonleao/gruvbox.nvim'
Plug 'rebelot/kanagawa.nvim'

" Treesitter for better highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Make treesitter work with nvim spell
Plug 'lewis6991/spellsitter.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround'

Plug 'neovim/nvim-lspconfig'
" Install language servers automatically:
Plug 'williamboman/nvim-lsp-installer'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

" Add plugins to &runtimepath
call plug#end()

" Theme ----------------------------------------------------------------------
" set background=dark
" syntax enable
" colorscheme gruvbox
colorscheme kanagawa

filetype indent plugin on

lua << EOF

  -- Colorscheme
  local default_colors = require("kanagawa.colors").setup()
  
  -- this will affect all the hl-groups where the redefined colors are used
  local my_colors = {
      -- use the palette color name...
      -- sumiInk1 = "black",
      fujiWhite = "#FBEED3",
      fujiGray = "#9D9D9E",  -- comments
  }
  require'kanagawa'.setup({ 
    commentStyle = { italic = false },
    overrides = overrides,
    colors = my_colors
  })
  vim.cmd("colorscheme kanagawa")

  -- Treesitter ---------------------------------------------------------------

  -- Nvim spell with treesitter
  require('spellsitter').setup()
  vim.opt.spell = true
  vim.opt.spelllang = { 'en_gb' }

  require('nvim-treesitter.configs').setup {
    -- A list of parser names, or "all"
    ensure_installed = { "c", "lua", "rust", "python" },
  
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,
  
    -- List of parsers to ignore installing (for "all")
    -- ignore_install = { "javascript" },
  
    highlight = {
      -- `false` will disable the whole extension
      enable = true,
  
      -- NOTE: these are the names of the parsers and not the filetype. (for
      -- example if you want to disable highlighting for the `tex` filetype,
      -- you need to include `latex` in this list as this is -- the name of the
      -- parser)

      -- list of language that will be disabled
      -- disable = { "c", "rust" },
  
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      -- additional_vim_regex_highlighting = false,
    }
  }

  -- cmp ----------------------------------------------------------------------

  -- Set completeopt to have a better completion experience
  vim.opt.completeopt = 'menuone,noselect'
  -- vim.opt.completeopt = "menu,menuone,noselect"

  -- Setup luasnip ------------------------------------------------------------
  local luasnip = require('luasnip')
  -- snippets from json files
  require("luasnip.loaders.from_vscode").lazy_load()
  luasnip.filetype_set("cu", { "c", "cpp" })
  -- print(cmp.core.sources)

  -- lsp setting --------------------------------------------------------------
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
    -- Lists all the implementations for the symbol under the cursor
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- Lists all the references
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- Displays a function's signature information
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  end

  -- nvim-cmp supports additional completion capabilities
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

  -- -------------------------------------------------------------------------
  -- lsp installer
  local lsp_installer = require("nvim-lsp-installer")
  lsp_installer.on_server_ready(function(server)
    local opts = {
    	on_attach = my_custom_on_attach,
    	capabilities = capabilities
    }
    opts.settings = {
      format = {enable = true},
    }
    -- This setup() function is exactly the same as lspconfig's setup function
    -- (:help lspconfig-quickstart)
    server:setup(opts)
    -- vim.cmd [[ do User LspAttachBuffers ]]
  end)

  -- Setup nvim-cmp. ---------------------------------------------------------
  local cmp = require('cmp')

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
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end),

      ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
      ['<Down>'] = cmp.mapping.select_next_item(select_opts),
      ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
      ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({select = true}),
      ['<C-Space>'] = cmp.mapping.complete(),
    },
    view = {
      entries = 'native'
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'buffer' },
      { name = 'path' }
      -- Notice that spell requires: vim.opt.spell = true
      -- { name = 'spell' }
    })
  })


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

  -- null-ls configuration:
  require("null-ls").setup({
      -- you must define at least one source for the plugin to work
      sources = {
          require("null-ls").builtins.diagnostics.flake8,
          require("null-ls").builtins.completion.spell
          -- require("null-ls").builtins.diagnostics.misspell
      },
      on_attach = my_custom_on_attach
  })
  -- nvim_lsp["null-ls"].setup({
  --     -- see the nvim-lspconfig documentation for available configuration options
  --     on_attach = my_custom_on_attach
  -- })

  -- Avoid diagnostic messages inline -> Use space+e
  vim.diagnostic.config({
    virtual_text = false,
  	underline = true,
	signs = true,
    float = {
      show_header = true,
      source = 'always',
      border = 'rounded',
      focusable = false,
    },
  })

  vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float()]]
  vim.cmd [[autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()]]

EOF

" airline --------------------------------------------------------------------

set laststatus=2
" let g:airline_theme           = 'gruvbox'
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
