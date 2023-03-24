-- Colorscheme

-- local default_colors = require("kanagawa.colors").setup()

-- this will affect all the hl-groups where the redefined colors are used
local my_colors = {
    -- use the palette color name...
    -- sumiInk1 = "black",
    palette = {
        fujiWhite = "#FBEED3",
        fujiGray = "#9D9D9E",  -- comments
    }
}

require'kanagawa'.setup({ 
    commentStyle = { italic = false },
    overrides = overrides,
    colors = my_colors
})

vim.cmd("colorscheme kanagawa")
