if true then
    return {

        -- add any tools you want to have installed below
        {
            "williamboman/mason.nvim",
            opts = {
                ensure_installed = {
                    "stylua",
                    -- "shellcheck",
                    "ruff-lsp",
                    "flake8",
                },
            },
        },
    }
end
