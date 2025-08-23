# Matugen Terminal Colors
# Generated from: /home/twinkie/Pictures/himalaya_gruvbox-dark.png
# Source color: #797466

# Apply OSC sequences for terminal colors (end-4 style)
function apply_terminal_colors
    # Basic 16 ANSI colors
    printf '\033]4;0;#15130b\033\\'          # black
    printf '\033]4;1;#ffb4ab\033\\'            # red
    printf '\033]4;2;#d1c6a1\033\\'        # green
    printf '\033]4;3;#a9d0b3\033\\'         # yellow
    printf '\033]4;4;#dbc66e\033\\'          # blue
    printf '\033]4;5;#93000a\033\\'  # magenta
    printf '\033]4;6;#534600\033\\' # cyan
    printf '\033]4;7;#e8e2d4\033\\'       # white
    printf '\033]4;8;#969080\033\\'          # bright black
    printf '\033]4;9;#690005\033\\'         # bright red
    printf '\033]4;10;#373016\033\\'    # bright green
    printf '\033]4;11;#153723\033\\'     # bright yellow
    printf '\033]4;12;#3a3000\033\\'      # bright blue
    printf '\033]4;13;#ffdad6\033\\' # bright magenta
    printf '\033]4;14;#f9e287\033\\' # bright cyan
    printf '\033]4;15;#15130b\033\\'      # bright white

    # Set terminal background, foreground, and cursor
    printf '\033]10;#e8e2d4\033\\'        # foreground
    printf '\033]11;#15130b\033\\'           # background
    printf '\033]12;#dbc66e\033\\'           # cursor

    # Additional compatibility
    printf '\033]708;#15130b\033\\'          # border color
end

set -U fish_color_normal "#e8e2d4"
set -U fish_color_command "#dbc66e"
set -U fish_color_keyword "#d1c6a1"
set -U fish_color_quote "#a9d0b3"
set -U fish_color_redirection "#cdc6b4"
set -U fish_color_end "#ffb4ab"
set -U fish_color_error "#ffb4ab"
set -U fish_color_param "#e8e2d4"
set -U fish_color_comment "#969080"
set -U fish_color_selection "#534600"
set -U fish_color_search_match "#4e472a"
set -U fish_color_operator "#cdc6b4"
set -U fish_color_escape "#2c4e38"
set -U fish_color_autosuggestion "#4b4739"

# Fish prompt colors
set -U fish_color_cwd "#dbc66e"
set -U fish_color_cwd_root "#ffb4ab"
set -U fish_color_user "#d1c6a1"
set -U fish_color_host "#a9d0b3"
set -U fish_color_host_remote "#153723"
set -U fish_color_status "#ffb4ab"

# Fish pager colors
set -U fish_pager_color_progress "#969080"
set -U fish_pager_color_background "#15130b"
set -U fish_pager_color_prefix "#dbc66e"
set -U fish_pager_color_completion "#e8e2d4"
set -U fish_pager_color_description "#cdc6b4"
set -U fish_pager_color_selected_background "#534600"
set -U fish_pager_color_selected_prefix "#f9e287"
set -U fish_pager_color_selected_completion "#f9e287"
set -U fish_pager_color_selected_description "#f9e287"

set -g matugen_primary "#dbc66e"
set -g matugen_on_primary "#3a3000"
set -g matugen_primary_container "#534600"
set -g matugen_on_primary_container "#f9e287"
set -g matugen_secondary "#d1c6a1"
set -g matugen_on_secondary "#373016"
set -g matugen_tertiary "#a9d0b3"
set -g matugen_on_tertiary "#153723"
set -g matugen_error "#ffb4ab"
set -g matugen_surface "#15130b"
set -g matugen_on_surface "#e8e2d4"
set -g matugen_background "#15130b"
set -g matugen_outline "#969080"

# mcolor function
function mcolor -d "Set color using matugen colors"
    switch $argv[1]
        case primary
            set_color $matugen_primary
        case on_primary
            set_color $matugen_on_primary
        case primary_container
            set_color $matugen_primary_container
        case secondary
            set_color $matugen_secondary
        case tertiary
            set_color $matugen_tertiary
        case error
            set_color $matugen_error
        case surface
            set_color $matugen_surface
        case on_surface
            set_color $matugen_on_surface
        case background
            set_color $matugen_background
        case outline
            set_color $matugen_outline
        case normal
            set_color normal
        case ''
            echo "Available colors: primary, secondary, tertiary, error, surface, background, outline, normal"
            return 1
        case '*'
            echo "Unknown color: $argv[1]"
            echo "Available colors: primary, secondary, tertiary, error, surface, background, outline, normal"
            return 1
    end
end

if status is-interactive
    apply_terminal_colors
end
