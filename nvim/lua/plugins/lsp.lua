return {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
        ---@type lspconfig.options
        servers = {
            ruff_lsp = {},
            texlab = {},
            ltex = {
                languageToolOrg = {
                    username = "",
                    apiKey = "",
                },
                languageToolHttpServerUri = "https://api.languagetoolplus.com",
                filetypes = {
                    "bib",
                    "gitcommit",
                    "latex",
                    "tex",
                    "mail",
                    "markdown",
                    "norg",
                    "org",
                    "pandoc",
                    "rst",
                    "text",
                },
                settings = {
                    -- https://valentjn.github.io/ltex/settings.html
                    ltex = {
                        -- unwanted checks are still occurring, often delaying CodeActions
                        checkFrequency = "save",
                        language = "en-GB",
                    },
                },
            },
        },
        setup = {
            clangd = function(_, opts)
                opts.capabilities.offsetEncoding = { "utf-16" }
            end,
        },
        -- options for vim.diagnostic.config()
        diagnostics = {
            underline = true,
            update_in_insert = false,
            virtual_text = false,
            -- virtual_text = {
            --     enabled = false,
            --     spacing = 4,
            --     source = "always",
            --     prefix = "●",
            --     -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            --     -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            --     -- prefix = "icons",
            -- },
            severity_sort = true,
            float = {
                source = "always",
            },
        },
    },
}
