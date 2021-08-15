# function fish_user_key_bindings
#   fish_vi_key_bindings default
# end
fish_vi_key_bindings
fish_vi_cursor
set fish_cursor_default block
set fish_cursor_insert underscore
set fish_cursor_visual block

bind -M default \r -m default execute

bind -M insert \cL forward-bigword
bind -M insert \cK history-search-backward
bind -M insert \cJ history-search-forward

alias ls "ls -lah --color"
alias sx "startx"
alias . "cd .."
alias .. "cd ../.."
alias ... "cd ../../.."

# set to use WINE32
set -x WINEPREFIX $HOME/.wine32
set -x WINEARCH   win32
