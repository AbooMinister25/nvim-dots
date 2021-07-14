local function keymap(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

function _G.completions()
    local npairs = require("nvim-autopairs")
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

local opts = {}

-- Telescope
keymap('n', "<Space>ff", "<cmd>Telescope find_files<CR>", opts)
keymap('n', "<Space>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap('n', "<Space>fb", "<cmd>Telescope buffers<CR>", opts)
keymap('n', "<Space>fh", "<cmd>Telescope help_tags<CR>", opts)

-- Nvim Tree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Neoformat
keymap("n", "<C-A-f>", [[<Cmd> Neoformat<CR>]], opts)

-- Bufferline
keymap("n", "<C-Right>", "[[:BufferLineCycleNext<CR>]]", opts)
keymap("n", "<C-Left>", "[[:BufferLineCyclePrev<CR>]]", opts)
keymap("n", "<C-w>", "[[:bd!<CR>]]", opts)

-- Move between windows
keymap("n", "<A-h>", "<C-W>h")
keymap("n", "<A-j>", "<C-W>j")
keymap("n", "<A-k>", "<C-W>k")
keymap("n", "<A-l>", "<C-W>l")

-- Commenter
keymap("n", "<A-/>", ":CommentToggle<CR>", opts)
keymap("v", "<A-/>", ":CommentToggle<CR>", opts)

-- undo/redo
keymap("n", "<C-z>", ":undo", opts)
keymap("n", "<C-y>", ":redo", opts)

-- compe
keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
keymap("i", "<CR>", "v:lua.completions()", {expr = true})

-- Save 
keymap("n", "<C-s>", ":w<CR>", opts)

-- Open Dashboard
keymap("n", "<C-A-h>", ":Dashboard<CR>", opts)

-- Terminal
keymap("n", "<C-l>", [[<Cmd>vnew term://zsh <CR>]], opts) -- term over right
keymap("n", "<C-t>", [[<Cmd> split term://zsh | resize 15 <CR>]], opts) --  term bottom
keymap("n", "<A-t>t", [[<Cmd> tabnew | term://zsh <CR>]], opts) -- term newtab
keymap("t", "<Esc>", "<C-\\><C-n>", opts)
