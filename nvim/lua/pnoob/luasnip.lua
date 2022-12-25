local luasnip = require('luasnip')

-- snippets from json files
require("luasnip.loaders.from_vscode").lazy_load()

luasnip.filetype_set("cu", { "c", "cpp" })
