return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        -- use opts = {} for passing setup options
    },
    {
        "stevearc/dressing.nvim",
        opts = {},
    },
    {
        "willothy/nvim-cokeline",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "stevearc/resession.nvim",
        },
        config = function()
            local get_hex = require("cokeline.hlgroups").get_hl_attr

            require("cokeline").setup({
                default_hl = {
                    fg = function(buffer)
                        return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
                    end,
                    bg = "NONE",
                },
                components = {
                    {
                        text = function(buffer)
                            return (buffer.index ~= 1) and "▏" or ""
                        end,
                        fg = function()
                            return get_hex("Normal", "fg")
                        end,
                    },
                    {
                        text = function(buffer)
                            return "    " .. buffer.devicon.icon
                        end,
                        fg = function(buffer)
                            return buffer.devicon.color
                        end,
                    },
                    {
                        text = function(buffer)
                            return buffer.filename .. "    "
                        end,
                        bold = function(buffer)
                            return buffer.is_focused
                        end,
                    },
                    {
                        text = "󰖭",
                        on_click = function(_, _, _, _, buffer)
                            buffer:delete()
                        end,
                    },
                    {
                        text = "  ",
                    },
                },
            })

            local map = vim.api.nvim_set_keymap

            map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
            map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 100,
                        tabline = 100,
                        winbar = 100,
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            })
        end,
    },
}
