return {
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        name = "onedark",
        style = 'deep',
    },
    {
        'olimorris/onedarkpro.nvim',
        priority = 1000,
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
        end
    },
    {
        "scottmckendry/cyberdream.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("cyberdream").setup({
                transparent = true,
                terminal_colors = true,
            })
        end
    },
    {
        "craftzdog/solarized-osaka.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            require("solarized-osaka").setup({
                transparent = false
            })
        end
    },
    {
        "rose-pine/neovim",
        lazy = false,
        priority = 1000,
        name = "rose-pine",
        opts = {},
        config = function()
            require("rose-pine").setup({
                transparent = false
            })
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    }
}
