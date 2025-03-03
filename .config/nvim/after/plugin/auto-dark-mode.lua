local auto_dark_mode = require('auto-dark-mode')

vim.cmd('colorscheme tokyonight-moon')

auto_dark_mode.setup({
    set_dark_mode = function()
        vim.opt.background = "dark"
        vim.cmd('colorscheme tokyonight-moon')
    end,
    set_light_mode = function()
        vim.opt.background = "light"
        vim.cmd('colorscheme tokyonight-day')
    end,
})
