# Matugen Terminal Colors
# Generated from: /home/twinkie/Pictures/anim2_biscuit-dark.jpg
# Source color: #cda985

# Apply OSC sequences for terminal colors (end-4 style)
function apply_terminal_colors
    # Basic 16 ANSI colors
    printf '\033]4;0;#19120c\033\\'          # black
    printf '\033]4;1;#ffb4ab\033\\'            # red
    printf '\033]4;2;#e0c1a3\033\\'        # green
    printf '\033]4;3;#becc9c\033\\'         # yellow
    printf '\033]4;4;#fbba73\033\\'          # blue
    printf '\033]4;5;#93000a\033\\'  # magenta
    printf '\033]4;6;#683d00\033\\' # cyan
    printf '\033]4;7;#eee0d5\033\\'       # white
    printf '\033]4;8;#9d8e81\033\\'          # bright black
    printf '\033]4;9;#690005\033\\'         # bright red
    printf '\033]4;10;#402d17\033\\'    # bright green
    printf '\033]4;11;#293411\033\\'     # bright yellow
    printf '\033]4;12;#492900\033\\'      # bright blue
    printf '\033]4;13;#ffdad6\033\\' # bright magenta
    printf '\033]4;14;#ffdcbb\033\\' # bright cyan
    printf '\033]4;15;#19120c\033\\'      # bright white

    # Set terminal background, foreground, and cursor
    printf '\033]10;#eee0d5\033\\'        # foreground
    printf '\033]11;#19120c\033\\'           # background
    printf '\033]12;#fbba73\033\\'           # cursor

    # Additional compatibility
    printf '\033]708;#19120c\033\\'          # border color
end

set -U fish_color_normal "#eee0d5"
set -U fish_color_command "#fbba73"
set -U fish_color_keyword "#e0c1a3"
set -U fish_color_quote "#becc9c"
set -U fish_color_redirection "#d5c4b5"
set -U fish_color_end "#ffb4ab"
set -U fish_color_error "#ffb4ab"
set -U fish_color_param "#eee0d5"
set -U fish_color_comment "#9d8e81"
set -U fish_color_selection "#683d00"
set -U fish_color_search_match "#58432c"
set -U fish_color_operator "#d5c4b5"
set -U fish_color_escape "#3f4b26"
set -U fish_color_autosuggestion "#50453a"

# Fish prompt colors
set -U fish_color_cwd "#fbba73"
set -U fish_color_cwd_root "#ffb4ab"
set -U fish_color_user "#e0c1a3"
set -U fish_color_host "#becc9c"
set -U fish_color_host_remote "#293411"
set -U fish_color_status "#ffb4ab"

# Fish pager colors
set -U fish_pager_color_progress "#9d8e81"
set -U fish_pager_color_background "#19120c"
set -U fish_pager_color_prefix "#fbba73"
set -U fish_pager_color_completion "#eee0d5"
set -U fish_pager_color_description "#d5c4b5"
set -U fish_pager_color_selected_background "#683d00"
set -U fish_pager_color_selected_prefix "#ffdcbb"
set -U fish_pager_color_selected_completion "#ffdcbb"
set -U fish_pager_color_selected_description "#ffdcbb"

set -g matugen_primary "#fbba73"
set -g matugen_on_primary "#492900"
set -g matugen_primary_container "#683d00"
set -g matugen_on_primary_container "#ffdcbb"
set -g matugen_secondary "#e0c1a3"
set -g matugen_on_secondary "#402d17"
set -g matugen_tertiary "#becc9c"
set -g matugen_on_tertiary "#293411"
set -g matugen_error "#ffb4ab"
set -g matugen_surface "#19120c"
set -g matugen_on_surface "#eee0d5"
set -g matugen_background "#19120c"
set -g matugen_outline "#9d8e81"

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
