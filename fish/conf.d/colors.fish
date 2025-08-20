# Matugen Terminal Colors
# Generated from: /home/twinkie/Pictures/oldhouse.gif
# Source color: #530f0e

# Apply OSC sequences for terminal colors (end-4 style)
function apply_terminal_colors
    # Basic 16 ANSI colors
    printf '\033]4;0;#1a1110\033\\'          # black
    printf '\033]4;1;#ffb4ab\033\\'            # red
    printf '\033]4;2;#e7bdb8\033\\'        # green
    printf '\033]4;3;#e1c38c\033\\'         # yellow
    printf '\033]4;4;#ffb3ac\033\\'          # blue
    printf '\033]4;5;#93000a\033\\'  # magenta
    printf '\033]4;6;#73332f\033\\' # cyan
    printf '\033]4;7;#f1dedc\033\\'       # white
    printf '\033]4;8;#a08c8a\033\\'          # bright black
    printf '\033]4;9;#690005\033\\'         # bright red
    printf '\033]4;10;#442927\033\\'    # bright green
    printf '\033]4;11;#3f2d04\033\\'     # bright yellow
    printf '\033]4;12;#571e1a\033\\'      # bright blue
    printf '\033]4;13;#ffdad6\033\\' # bright magenta
    printf '\033]4;14;#ffdad6\033\\' # bright cyan
    printf '\033]4;15;#1a1110\033\\'      # bright white

    # Set terminal background, foreground, and cursor
    printf '\033]10;#f1dedc\033\\'        # foreground
    printf '\033]11;#1a1110\033\\'           # background
    printf '\033]12;#ffb3ac\033\\'           # cursor

    # Additional compatibility
    printf '\033]708;#1a1110\033\\'          # border color
end

set -U fish_color_normal "#f1dedc"
set -U fish_color_command "#ffb3ac"
set -U fish_color_keyword "#e7bdb8"
set -U fish_color_quote "#e1c38c"
set -U fish_color_redirection "#d8c2bf"
set -U fish_color_end "#ffb4ab"
set -U fish_color_error "#ffb4ab"
set -U fish_color_param "#f1dedc"
set -U fish_color_comment "#a08c8a"
set -U fish_color_selection "#73332f"
set -U fish_color_search_match "#5d3f3c"
set -U fish_color_operator "#d8c2bf"
set -U fish_color_escape "#584419"
set -U fish_color_autosuggestion "#534341"

# Fish prompt colors
set -U fish_color_cwd "#ffb3ac"
set -U fish_color_cwd_root "#ffb4ab"
set -U fish_color_user "#e7bdb8"
set -U fish_color_host "#e1c38c"
set -U fish_color_host_remote "#3f2d04"
set -U fish_color_status "#ffb4ab"

# Fish pager colors
set -U fish_pager_color_progress "#a08c8a"
set -U fish_pager_color_background "#1a1110"
set -U fish_pager_color_prefix "#ffb3ac"
set -U fish_pager_color_completion "#f1dedc"
set -U fish_pager_color_description "#d8c2bf"
set -U fish_pager_color_selected_background "#73332f"
set -U fish_pager_color_selected_prefix "#ffdad6"
set -U fish_pager_color_selected_completion "#ffdad6"
set -U fish_pager_color_selected_description "#ffdad6"

set -g matugen_primary "#ffb3ac"
set -g matugen_on_primary "#571e1a"
set -g matugen_primary_container "#73332f"
set -g matugen_on_primary_container "#ffdad6"
set -g matugen_secondary "#e7bdb8"
set -g matugen_on_secondary "#442927"
set -g matugen_tertiary "#e1c38c"
set -g matugen_on_tertiary "#3f2d04"
set -g matugen_error "#ffb4ab"
set -g matugen_surface "#1a1110"
set -g matugen_on_surface "#f1dedc"
set -g matugen_background "#1a1110"
set -g matugen_outline "#a08c8a"

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
