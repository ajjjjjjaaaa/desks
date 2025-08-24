function apply_terminal_colors
    # Basic 16 ANSI colors
    printf '\033]4;0;#fff9eb\033\\'          # black
    printf '\033]4;1;#ba1a1a\033\\'            # red
    printf '\033]4;2;#655f41\033\\'        # green
    printf '\033]4;3;#416651\033\\'         # yellow
    printf '\033]4;4;#6a5f11\033\\'          # blue
    printf '\033]4;5;#ffdad6\033\\'  # magenta
    printf '\033]4;6;#f4e489\033\\' # cyan
    printf '\033]4;7;#1d1c13\033\\'       # white
    printf '\033]4;8;#7b7768\033\\'          # bright black
    printf '\033]4;9;#ffffff\033\\'         # bright red
    printf '\033]4;10;#ffffff\033\\'    # bright green
    printf '\033]4;11;#ffffff\033\\'     # bright yellow
    printf '\033]4;12;#ffffff\033\\'      # bright blue
    printf '\033]4;13;#410002\033\\' # bright magenta
    printf '\033]4;14;#201c00\033\\' # bright cyan
    printf '\033]4;15;#fff9eb\033\\'      # bright white

    # Set terminal background, foreground, and cursor
    printf '\033]10;#1d1c13\033\\'        # foreground
    printf '\033]11;#fff9eb\033\\'           # background
    printf '\033]12;#6a5f11\033\\'           # cursor

    # Additional compatibility
    printf '\033]708;#fff9eb\033\\'          # border color
end

set -U fish_color_normal "#1d1c13"
set -U fish_color_command "#6a5f11"
set -U fish_color_keyword "#655f41"
set -U fish_color_quote "#416651"
set -U fish_color_redirection "#4a4739"
set -U fish_color_end "#ba1a1a"
set -U fish_color_error "#ba1a1a"
set -U fish_color_param "#1d1c13"
set -U fish_color_comment "#7b7768"
set -U fish_color_selection "#f4e489"
set -U fish_color_search_match "#ece3bd"
set -U fish_color_operator "#4a4739"
set -U fish_color_escape "#c3ecd1"
set -U fish_color_autosuggestion "#ccc6b5"

# Fish prompt colors
set -U fish_color_cwd "#6a5f11"
set -U fish_color_cwd_root "#ba1a1a"
set -U fish_color_user "#655f41"
set -U fish_color_host "#416651"
set -U fish_color_host_remote "#ffffff"
set -U fish_color_status "#ba1a1a"

# Fish pager colors
set -U fish_pager_color_progress "#7b7768"
set -U fish_pager_color_background "#fff9eb"
set -U fish_pager_color_prefix "#6a5f11"
set -U fish_pager_color_completion "#1d1c13"
set -U fish_pager_color_description "#4a4739"
set -U fish_pager_color_selected_background "#f4e489"
set -U fish_pager_color_selected_prefix "#201c00"
set -U fish_pager_color_selected_completion "#201c00"
set -U fish_pager_color_selected_description "#201c00"

set -g matugen_primary "#6a5f11"
set -g matugen_on_primary "#ffffff"
set -g matugen_primary_container "#f4e489"
set -g matugen_on_primary_container "#201c00"
set -g matugen_secondary "#655f41"
set -g matugen_on_secondary "#ffffff"
set -g matugen_tertiary "#416651"
set -g matugen_on_tertiary "#ffffff"
set -g matugen_error "#ba1a1a"
set -g matugen_surface "#fff9eb"
set -g matugen_on_surface "#1d1c13"
set -g matugen_background "#fff9eb"
set -g matugen_outline "#7b7768"

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
