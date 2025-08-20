# Matugen Terminal Colors
# Generated from: {{image}}
# Source color: {{colors.source_color.dark.hex}}

# Apply OSC sequences for terminal colors (end-4 style)
function apply_terminal_colors
    # Basic 16 ANSI colors
    printf '\033]4;0;{{colors.surface.dark.hex}}\033\\'          # black
    printf '\033]4;1;{{colors.error.dark.hex}}\033\\'            # red
    printf '\033]4;2;{{colors.secondary.dark.hex}}\033\\'        # green
    printf '\033]4;3;{{colors.tertiary.dark.hex}}\033\\'         # yellow
    printf '\033]4;4;{{colors.primary.dark.hex}}\033\\'          # blue
    printf '\033]4;5;{{colors.error_container.dark.hex}}\033\\'  # magenta
    printf '\033]4;6;{{colors.primary_container.dark.hex}}\033\\' # cyan
    printf '\033]4;7;{{colors.on_surface.dark.hex}}\033\\'       # white
    printf '\033]4;8;{{colors.outline.dark.hex}}\033\\'          # bright black
    printf '\033]4;9;{{colors.on_error.dark.hex}}\033\\'         # bright red
    printf '\033]4;10;{{colors.on_secondary.dark.hex}}\033\\'    # bright green
    printf '\033]4;11;{{colors.on_tertiary.dark.hex}}\033\\'     # bright yellow
    printf '\033]4;12;{{colors.on_primary.dark.hex}}\033\\'      # bright blue
    printf '\033]4;13;{{colors.on_error_container.dark.hex}}\033\\' # bright magenta
    printf '\033]4;14;{{colors.on_primary_container.dark.hex}}\033\\' # bright cyan
    printf '\033]4;15;{{colors.background.dark.hex}}\033\\'      # bright white
    
    # Set terminal background, foreground, and cursor
    printf '\033]10;{{colors.on_surface.dark.hex}}\033\\'        # foreground
    printf '\033]11;{{colors.surface.dark.hex}}\033\\'           # background
    printf '\033]12;{{colors.primary.dark.hex}}\033\\'           # cursor
    
    # Additional compatibility
    printf '\033]708;{{colors.surface.dark.hex}}\033\\'          # border color
end

# Fish syntax highlighting colors
set -U fish_color_normal "{{colors.on_surface.dark.hex}}"
set -U fish_color_command "{{colors.primary.dark.hex}}"
set -U fish_color_keyword "{{colors.secondary.dark.hex}}"
set -U fish_color_quote "{{colors.tertiary.dark.hex}}"
set -U fish_color_redirection "{{colors.on_surface_variant.dark.hex}}"
set -U fish_color_end "{{colors.error.dark.hex}}"
set -U fish_color_error "{{colors.error.dark.hex}}"
set -U fish_color_param "{{colors.on_surface.dark.hex}}"
set -U fish_color_comment "{{colors.outline.dark.hex}}"
set -U fish_color_selection "{{colors.primary_container.dark.hex}}"
set -U fish_color_search_match "{{colors.secondary_container.dark.hex}}"
set -U fish_color_operator "{{colors.on_surface_variant.dark.hex}}"
set -U fish_color_escape "{{colors.tertiary_container.dark.hex}}"
set -U fish_color_autosuggestion "{{colors.outline_variant.dark.hex}}"

# Fish prompt colors
set -U fish_color_cwd "{{colors.primary.dark.hex}}"
set -U fish_color_cwd_root "{{colors.error.dark.hex}}"
set -U fish_color_user "{{colors.secondary.dark.hex}}"
set -U fish_color_host "{{colors.tertiary.dark.hex}}"
set -U fish_color_host_remote "{{colors.on_tertiary.dark.hex}}"
set -U fish_color_status "{{colors.error.dark.hex}}"

# Fish pager colors
set -U fish_pager_color_progress "{{colors.outline.dark.hex}}"
set -U fish_pager_color_background "{{colors.surface.dark.hex}}"
set -U fish_pager_color_prefix "{{colors.primary.dark.hex}}"
set -U fish_pager_color_completion "{{colors.on_surface.dark.hex}}"
set -U fish_pager_color_description "{{colors.on_surface_variant.dark.hex}}"
set -U fish_pager_color_selected_background "{{colors.primary_container.dark.hex}}"
set -U fish_pager_color_selected_prefix "{{colors.on_primary_container.dark.hex}}"
set -U fish_pager_color_selected_completion "{{colors.on_primary_container.dark.hex}}"
set -U fish_pager_color_selected_description "{{colors.on_primary_container.dark.hex}}"

# Export color variables for mcolor function
set -g matugen_primary "{{colors.primary.dark.hex}}"
set -g matugen_on_primary "{{colors.on_primary.dark.hex}}"
set -g matugen_primary_container "{{colors.primary_container.dark.hex}}"
set -g matugen_on_primary_container "{{colors.on_primary_container.dark.hex}}"
set -g matugen_secondary "{{colors.secondary.dark.hex}}"
set -g matugen_on_secondary "{{colors.on_secondary.dark.hex}}"
set -g matugen_tertiary "{{colors.tertiary.dark.hex}}"
set -g matugen_on_tertiary "{{colors.on_tertiary.dark.hex}}"
set -g matugen_error "{{colors.error.dark.hex}}"
set -g matugen_surface "{{colors.surface.dark.hex}}"
set -g matugen_on_surface "{{colors.on_surface.dark.hex}}"
set -g matugen_background "{{colors.background.dark.hex}}"
set -g matugen_outline "{{colors.outline.dark.hex}}"

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

