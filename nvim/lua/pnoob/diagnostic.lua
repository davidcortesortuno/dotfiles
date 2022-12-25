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
