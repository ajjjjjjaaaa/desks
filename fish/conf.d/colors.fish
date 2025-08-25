function apply_terminal_colors
    # Basic 16 ANSI colors
    printf '\033]4;0;#171217\033\\'          # black
    printf '\033]4;1;#ffb4ab\033\\'            # red
    printf '\033]4;2;#d6c0d6\033\\'        # green
    printf '\033]4;3;#f5b7b0\033\\'         # yellow
    printf '\033]4;4;#e9b5ef\033\\'          # blue
    printf '\033]4;5;#93000a\033\\'  # magenta
    printf '\033]4;6;#603768\033\\' # cyan
    printf '\033]4;7;#eae0e7\033\\'       # white
    printf '\033]4;8;#988e97\033\\'          # bright black
    printf '\033]4;9;#690005\033\\'         # bright red
    printf '\033]4;10;#3a2b3c\033\\'    # bright green
    printf '\033]4;11;#4c2521\033\\'     # bright yellow
    printf '\033]4;12;#472150\033\\'      # bright blue
    printf '\033]4;13;#ffdad6\033\\' # bright magenta
    printf '\033]4;14;#fdd6ff\033\\' # bright cyan
    printf '\033]4;15;#171217\033\\'      # bright white

    # Set terminal background, foreground, and cursor
    printf '\033]10;#eae0e7\033\\'        # foreground
    printf '\033]11;#171217\033\\'           # background
    printf '\033]12;#e9b5ef\033\\'           # cursor

    # Additional compatibility
    printf '\033]708;#171217\033\\'          # border color
end

set -U fish_color_normal "#eae0e7"
set -U fish_color_command "#e9b5ef"
set -U fish_color_keyword "#d6c0d6"
set -U fish_color_quote "#f5b7b0"
set -U fish_color_redirection "#cfc3cd"
set -U fish_color_end "#ffb4ab"
set -U fish_color_error "#ffb4ab"
set -U fish_color_param "#eae0e7"
set -U fish_color_comment "#988e97"
set -U fish_color_selection "#603768"
set -U fish_color_search_match "#524153"
set -U fish_color_operator "#cfc3cd"
set -U fish_color_escape "#673b36"
set -U fish_color_autosuggestion "#4d444c"

# Fish prompt colors
set -U fish_color_cwd "#e9b5ef"
set -U fish_color_cwd_root "#ffb4ab"
set -U fish_color_user "#d6c0d6"
set -U fish_color_host "#f5b7b0"
set -U fish_color_host_remote "#4c2521"
set -U fish_color_status "#ffb4ab"

# Fish pager colors
set -U fish_pager_color_progress "#988e97"
set -U fish_pager_color_background "#171217"
set -U fish_pager_color_prefix "#e9b5ef"
set -U fish_pager_color_completion "#eae0e7"
set -U fish_pager_color_description "#cfc3cd"
set -U fish_pager_color_selected_background "#603768"
set -U fish_pager_color_selected_prefix "#fdd6ff"
set -U fish_pager_color_selected_completion "#fdd6ff"
set -U fish_pager_color_selected_description "#fdd6ff"

set -g matugen_primary "#e9b5ef"
set -g matugen_on_primary "#472150"
set -g matugen_primary_container "#603768"
set -g matugen_on_primary_container "#fdd6ff"
set -g matugen_secondary "#d6c0d6"
set -g matugen_on_secondary "#3a2b3c"
set -g matugen_tertiary "#f5b7b0"
set -g matugen_on_tertiary "#4c2521"
set -g matugen_error "#ffb4ab"
set -g matugen_surface "#171217"
set -g matugen_on_surface "#eae0e7"
set -g matugen_background "#171217"
set -g matugen_outline "#988e97"

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
