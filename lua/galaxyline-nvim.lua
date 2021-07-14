local gl = require("galaxyline")
local gls = gl.section
local devicons = require 'nvim-web-devicons'
local condition = require("galaxyline.condition")

local colors = require("themes/onedark")

local mode_colors = {
    n = colors.nord_blue,
    i = colors.blue,
    c = colors.dark_purple,
    v = colors.orange,
    [''] = colors.orange,
    V = colors.orange,
    R = colors.red
}

local mode_color = function()
    local current_Mode = vim.fn.mode()
    if current_Mode == nil then return colors.green end
    return mode_colors[vim.fn.mode()]
end

local function highlight(group, fg, bg, gui)
    local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
    if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
    vim.cmd(cmd)
end

local function buffer_not_empty()
    if vim.fn.empty(vim.fn.expand '%:t') ~= 1 then return true end
    return false
end

gls.left[1] = {
    ViMode = {
        provider = function()
            local alias = {
                n = " NORMAL",
                i = " INSERT",
                c = " COMMAND",
                V = " Visual",
                [""] = " Visual",
                v = " Visual",
                R = " Replace"
            }
            local current_Mode = alias[vim.fn.mode()]
            local mode_Color = mode_color()

            if mode_Color == nil then mode_Color = colors.green end

            if current_Mode == nil then current_Mode = " Terminal" end

            vim.api.nvim_command('hi GalaxyViMode guibg=' .. mode_Color ..
                                     ' gui=bold')

            return ' ' .. current_Mode .. ' '
        end,
        separator = " ",
        separator_highlight = {colors.lightbg, colors.lightbg},
        highlight = {colors.lightbg, colors.lightbg}
    }
}

gls.left[2] = {
    FileIcon = {
        provider = function()
            local fname, ext = vim.fn.expand '%:t', vim.fn.expand '%:e'
            local icon, iconhl = devicons.get_icon(fname, ext)
            if icon == nil then return '' end
            local fg = vim.fn.synIDattr(vim.fn.hlID(iconhl), 'fg')
            highlight('GalaxyFileIcon', fg, colors.lightbg)
            return ' ' .. icon .. '  '
        end,
        condition = buffer_not_empty
    }
}

gls.left[3] = {
    FileName = {
        provider = "FileName",
        condition = condition.buffer_not_empty,
        highlight = {colors.white, colors.lightbg},
        separator = "",
        separator_highlight = {colors.lightbg, colors.lightbg2}
    }
}

gls.left[4] = {
    current_dir = {
        provider = function()
            local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
            return "  " .. dir_name .. " "
        end,
        highlight = {colors.grey_fg2, colors.lightbg2},
        separator = " ",
        separator_highlight = {colors.lightbg2, colors.statusline_bg}
    }
}

gls.right[1] = {
    SepIcon2 = {
        provider = function() return "  " end,
        highlight = {colors.yellow, colors.lightbg}
    }
}

gls.right[2] = {
    GitIcon = {
        provider = function()
            local icon, iconhl = devicons.get_icon("git", "git")
            local fg = vim.fn.synIDattr(vim.fn.hlID(iconhl), 'fg')
            highlight('GalaxyGitIcon', fg, colors.lightbg)
            return " " .. icon .. " "
        end,
        condition = require("galaxyline.provider_vcs").check_git_workspace
    }
}

gls.right[3] = {
    GitBranch = {
        provider = "GitBranch",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.yellow, colors.lightbg}
    }
}

gls.right[4] = {
    SepIcon = {
        provider = function() return "  " end,
        highlight = {colors.blue, colors.lightbg}
    }
}

gls.right[5] = {
    PositionInfo = {
        provider = {
            function()
                return string.format(' %s:%s ', vim.fn.line('.'),
                                     vim.fn.col('.'))
            end
        },
        highlight = {colors.blue, colors.lightbg},
        separator = " ",
        separator_highlight = {colors.blue, colors.lightbg},
        condition = buffer_not_empty
    }
}

gls.right[6] = {
    DiagnosticError = {
        provider = "DiagnosticError",
        icon = "  ",
        highlight = {colors.red, colors.statusline_bg}
    }
}

gls.left[7] = {
    DiagnosticWarn = {
        provider = "DiagnosticWarn",
        icon = "  ",
        highlight = {colors.yellow, colors.statusline_bg}
    }
}
