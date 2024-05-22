return {
    "mfussenegger/nvim-lint",
    event = "LazyFile",
    opts = {
        -- Event to trigger linters
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
            fish = { "fish" },
            python = { "flake8" },
            text = { "proselint" },
            tex = { "proselint" },
        },
        ---@type table<string,table>
        linters = {
            flake8 = {args={"--ignore=E501"}},
            -- -- Example of using selene only when a selene.toml file is present
            -- selene = {
            --   -- `condition` is another LazyVim extension that allows you to
            --   -- dynamically enable/disable linters based on the context.
            --   condition = function(ctx)
            --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
            --   end,
            -- },
        },
    },
}
