# Matugen Terminal Colors
# Generated from: /home/twinkie/Pictures/anim2.jpg
# Source color: #8276d8

# Apply OSC sequences for terminal colors (end-4 style)
function apply_terminal_colors
    # Basic 16 ANSI colors
    printf '\033]4;0;#141318\033\\'          # black
    printf '\033]4;1;#ffb4ab\033\\'            # red
    printf '\033]4;2;#c8c3dc\033\\'        # green
    printf '\033]4;3;#ecb8ce\033\\'         # yellow
    printf '\033]4;4;#c7bfff\033\\'          # blue
    printf '\033]4;5;#93000a\033\\'  # magenta
    printf '\033]4;6;#463f77\033\\' # cyan
    printf '\033]4;7;#e5e1e9\033\\'       # white
    printf '\033]4;8;#928f99\033\\'          # bright black
    printf '\033]4;9;#690005\033\\'         # bright red
    printf '\033]4;10;#312e41\033\\'    # bright green
    printf '\033]4;11;#482536\033\\'     # bright yellow
    printf '\033]4;12;#2f285f\033\\'      # bright blue
    printf '\033]4;13;#ffdad6\033\\' # bright magenta
    printf '\033]4;14;#e5deff\033\\' # bright cyan
    printf '\033]4;15;#141318\033\\'      # bright white
    
    # Set terminal background, foreground, and cursor
    printf '\033]10;#e5e1e9\033\\'        # foreground
    printf '\033]11;#141318\033\\'           # background
    printf '\033]12;#c7bfff\033\\'           # cursor
    
    # Additional compatibility
    printf '\033]708;#141318\033\\'          # border color
end

# Fish syntax highlighting colors
set -U fish_color_normal "#e5e1e9"
set -U fish_color_command "#c7bfff"
set -U fish_color_keyword "#c8c3dc"
set -U fish_color_quote "#ecb8ce"
set -U fish_color_redirection "#c9c5d0"
set -U fish_color_end "#ffb4ab"
set -U fish_color_error "#ffb4ab"
set -U fish_color_param "#e5e1e9"
set -U fish_color_comment "#928f99"
set -U fish_color_selection "#463f77"
set -U fish_color_search_match "#474459"
set -U fish_color_operator "#c9c5d0"
set -U fish_color_escape "#613b4d"
set -U fish_color_autosuggestion "#48464f"

# Fish prompt colors
set -U fish_color_cwd "#c7bfff"
set -U fish_color_cwd_root "#ffb4ab"
set -U fish_color_user "#c8c3dc"
set -U fish_color_host "#ecb8ce"
set -U fish_color_host_remote "#482536"
set -U fish_color_status "#ffb4ab"

# Fish pager colors
set -U fish_pager_color_progress "#928f99"
set -U fish_pager_color_background "#141318"
set -U fish_pager_color_prefix "#c7bfff"
set -U fish_pager_color_completion "#e5e1e9"
set -U fish_pager_color_description "#c9c5d0"
set -U fish_pager_color_selected_background "#463f77"
set -U fish_pager_color_selected_prefix "#e5deff"
set -U fish_pager_color_selected_completion "#e5deff"
set -U fish_pager_color_selected_description "#e5deff"

# Export color variables for mcolor function
set -g matugen_primary "#c7bfff"
set -g matugen_on_primary "#2f285f"
set -g matugen_primary_container "#463f77"
set -g matugen_on_primary_container "#e5deff"
set -g matugen_secondary "#c8c3dc"
set -g matugen_on_secondary "#312e41"
set -g matugen_tertiary "#ecb8ce"
set -g matugen_on_tertiary "#482536"
set -g matugen_error "#ffb4ab"
set -g matugen_surface "#141318"
set -g matugen_on_surface "#e5e1e9"
set -g matugen_background "#141318"
set -g matugen_outline "#928f99"

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

# Apply colors when loaded
if status is-interactive
    apply_terminal_colors
end

