
if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting

end

starship init fish | source
source ~/.config/fish/conf.d/colors.fish

alias pamcan pacman
alias ls 'eza --icons'
alias clear "printf '\033[2J\033[3J\033[1;1H'"
alias qd 'qs -d'
alias q 'qs'

# function fish_prompt
#   set_color cyan; echo (pwd)
#   set_color green; echo '> '
# end
