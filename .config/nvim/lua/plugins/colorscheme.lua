return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("tokyonight").setup({
                style = "night",
                styles = {
                    functions = {},
                },
                on_colors = function(colors)
                    colors.hint = colors.orange
                    colors.error = "#ff0000"
                end,
                transparent = true,
            })
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            vim.cmd("colorscheme gruvbox")
        end,
        opts = ...,
    },

    {
        "xiyaowong/transparent.nvim",
        priority = 1000,
        config = function()
            -- Optional, you don't have to run setup.
            require("transparent").setup({
                -- table: default groups
                groups = {
                    "Normal",
                    "NormalNC",
                    "Comment",
                    "Constant",
                    "Special",
                    "Identifier",
                    "Statement",
                    "PreProc",
                    "Type",
                    "Underlined",
                    "Todo",
                    "String",
                    "Function",
                    "Conditional",
                    "Repeat",
                    "Operator",
                    "Structure",
                    "LineNr",
                    "NonText",
                    "SignColumn",
                    "CursorLine",
                    "CursorLineNr",
                    "StatusLine",
                    "StatusLineNC",
                    "EndOfBuffer",
                },
                -- table: additional groups that should be cleared
                extra_groups = {},
                -- table: groups you don't want to clear
                exclude_groups = {},
                -- function: code to be executed after highlight groups are cleared
                -- Also the user event "TransparentClear" will be triggered
                on_clear = function() end,
            })
        end,
        opts = ...,
    },
}
