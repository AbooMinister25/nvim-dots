require("bufferline").setup {
    options = {
        offsets = {{filetype = "NvimTree", text = "", padding = 1}},
        left_mouse_command = "buffer %d",
        close_command = "bdelete! %d",
        buffer_close_icon = "",
        modified_icon = "",
        close_icon = "",
        right_trunc_marker = "",
        max_name_length = 14,
        max_prefix_length = 13,
        tab_size = 20,
        show_tab_indicators = true,
        enforce_regular_tabs = false,
        view = "multiwindow",
        show_buffer_close_icons = true,
        separator_style = "thick",
        mappings = "true",
        diagnostics = "nvim_lsp"
    }
}
