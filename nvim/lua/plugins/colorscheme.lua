-- this will affect all the hl-groups where the redefined colors are used
local my_colors = {
    -- change all usages of these colors
    palette = {
        fujiWhite = "#FBEED3",
        fujiGray = "#9D9D9E",
    }
}

return {

    {
        "rebelot/kanagawa.nvim",
        opts = {
            commentStyle = { italic = false },
            -- overrides = overrides,
            colors = my_colors,
        },
    },

    -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "kanagawa",
        },
    },
}
