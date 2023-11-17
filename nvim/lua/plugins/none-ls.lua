return {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
        local nls = require("null-ls")
        return {
            root_dir = require("null-ls.utils").root_pattern(
                ".null-ls-root",
                ".neoconf.json",
                "Makefile",
                ".git"
            ),
            sources = {
                nls.builtins.diagnostics.ruff.with({
                    extra_args = { "--ignore=E501" },
                }),
                nls.builtins.completion.spell,
                nls.builtins.diagnostics.proselint,
            },
        }
    end,
}
