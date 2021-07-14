local packer = require("packer")
local use = packer.use

return packer.startup(function()
    use "siduck76/nvim-base16.lua"
    use "wbthomason/packer.nvim"
    use "kyazdani42/nvim-web-devicons"
    use 'nvim-treesitter/nvim-treesitter'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use "lukas-reineke/indent-blankline.nvim"
    use {'glepnir/galaxyline.nvim', branch = 'main'}

    use {"kabouzeid/nvim-lspinstall"}
    use {"neovim/nvim-lspconfig"}
    use {"onsails/lspkind-nvim"}
    use {
        "hrsh7th/nvim-compe",
        wants = {"LuaSnip"},
        requires = {
            {"L3MON4D3/LuaSnip", wants = "friendly-snippets"},
            {"rafamadriz/friendly-snippets"}
        }
    }
    use {'akinsho/nvim-bufferline.lua'}
    use {"kyazdani42/nvim-tree.lua"}
    use {"sbdchd/neoformat"}
    use {"norcalli/nvim-colorizer.lua"}
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use {"windwp/nvim-autopairs"}
    use {"terrortylor/nvim-comment"}
    use 'karb94/neoscroll.nvim'
    use {"glepnir/dashboard-nvim"}
end)
