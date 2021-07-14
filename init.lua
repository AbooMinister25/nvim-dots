vim.cmd("set termguicolors")

require "pluginsList"

require "galaxyline-nvim"

require "nvimtree-nvim"

require "nvim-dashboard"

require "bufferline-nvim"

require "lspconfig-nvim"

require "compe-nvim"

require "luasnippets-nvim"

require "mapping-nvim"

require "gitsigns-nvim"

require "treesitter-nvim"

require'colorizer'.setup()

require('nvim-autopairs').setup()

require('nvim_comment').setup()

require('neoscroll').setup()

require("indent-nvim")

require("indent_blankline").setup()

vim.cmd("set number")
vim.cmd("set splitbelow")

local g = vim.g

g.indent_blankline_enabled = 1

vim.g.indent_blankline_bufname_exclude = {
    "DashboardHeader", "DashboardCenter", "DashboardHeader",
    "DashboardShortcut", "DashboardFooter", "DashboardNewFile"
}

local base16 = require "base16"
base16(base16.themes["onedark"], true)

require "highlights"

vim.api.nvim_exec([[
   au BufEnter term://* setlocal nonumber
   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
   au BufEnter term://* set laststatus=0 
]], false)

