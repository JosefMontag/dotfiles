function fish_user_key_bindings
  fish_vi_key_bindings default
end

bind -M default \r -m default execute

bind -M insert \cL forward-bigword
bind -M insert \cK history-search-backward
bind -M insert \cJ history-search-forward

alias ls "ls -lah --color"

# set to use WINE32
set -x WINEPREFIX $HOME/.wine32
set -x WINEARCH   win32
