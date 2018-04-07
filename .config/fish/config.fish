set -g theme_color_scheme terminal-light-black
set -g theme_nerd_fonts yes
set -g theme_display_date no

function fish_greeting
  zen | cowsay -f doot
end

funcsave fish_greeting
