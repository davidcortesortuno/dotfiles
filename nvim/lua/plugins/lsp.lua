-- add pyright to lspconfig
return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      -- pyright will be automatically installed with mason and loaded with lspconfig
      pyright = {},
    },
    setup = {
      clangd = function(_, opts)
        opts.capabilities.offsetEncoding = { "utf-16" }
      end,
    }
  },
}
