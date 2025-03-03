package.path = package.path .. ';' .. vim.fn.expand('~/.config/nvim/lua/?.lua')

require("plugins.remap")
require("plugins.packer")
require("plugins.set")
