-- Mason (ex lsp-installer)

local lspconfig = require('lspconfig')

-- Disable virtual text
vim.diagnostic.config({
    virtual_text = false,
})

-- Word dictionary from nvim to be used in ltex-ls
local words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
	table.insert(words, word)
end

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "ltex", "pyright", "clangd", "rust_analyzer", "diagnosticls" },
}

require('mason-lspconfig').setup_handlers({
    function(server)
      lspconfig[server].setup({})
    end,
    -- Next we set dedicated handlers for specific servers:
    ['ltex'] = function()
        lspconfig['ltex'].setup {
            on_attach = my_custom_on_attach,
            capabilities = capabilities,
            settings = {
                ltex = {
                    language = {"en-GB", "en_US"},
                    additionalRules = {
                        languageModel = '~/ngrams-en/',
                    },
                    dictionary = {
                        ["en-US"] = words,
                    },
                    --disabledRules = { ['en-US'] = { 'PROFANITY' } },
                },
            },
        }
        end
})

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
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- null-ls configuration:
require("null-ls").setup({
-- you must define at least one source for the plugin to work
-- flake8: ignore long lines error (E501)
sources = {
    require("null-ls").builtins.diagnostics.ruff.with({
      extra_args={"--ignore=E501"},
    }),
    require("null-ls").builtins.completion.spell,
    -- require("null-ls").builtins.diagnostics.misspell.with({filetypes = { "tex", "text" }}),
    require("null-ls").builtins.diagnostics.proselint,
},
on_attach = my_custom_on_attach
})

-- Use internal formatting for bindings like gq: https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131 
vim.api.nvim_create_autocmd('LspAttach', { 
   callback = function(args) 
   vim.bo[args.buf].formatexpr = nil 
 end, 
})
-- lspconfig["null-ls"].setup({
--     -- see the nvim-lspconfig documentation for available configuration options
--     on_attach = my_custom_on_attach
-- })

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
