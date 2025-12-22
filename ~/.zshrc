export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# aliases {{{1
alias x="startx"
alias cat="bat"
alias ..="cd .."
alias cd="z"
alias vim="nvim"

gitpush() {
  git add -A
  local msg
  read -r "msg?Commit message: "
  [ -n "$msg" ] && git commit -m "$msg" || git commit
  git push
}

# Replace ls with lsd
alias ls='lsd -a --group-dirs first --icon=auto --color=auto'
alias ld='lsd -lha --group-dirs first --icon=auto --color=auto'
alias lt='lsd -a --tree --depth=2 --group-dirs first --icon=auto --color=auto'

# --- 1. Initialize Plugin Manager ---
# Download Znap, if it's not there yet.
[[ -r ~/.znap/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.znap/znap
source ~/.znap/znap/znap.zsh

# --- 2. Powerlevel10k Instant Prompt ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- 3. Initialize Completion System (MUST BE BEFORE FZF-TAB) ---
autoload -Uz compinit
compinit -d ~/.cache/zsh/.zcompdump
zmodload zsh/complist

# --- 4. Load Completion Plugins ---
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab

# --- 5. Configure Completion & Fzf-Tab ---
# Standard Zsh menu selection
zstyle ':completion:*' menu select
unsetopt menu_complete

# FZF-TAB CONFIGURATION
# Disable fzf-tab for autosuggestions (speeds things up)
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# Switch to recursive search for 'cd' automatically
zstyle ':fzf-tab:complete:cd:*' completion-strategy recursive-search

# --- 6. Core Plugins (Load LAST to avoid conflicts) ---
znap source zsh-users/zsh-autosuggestions
znap source zdharma-continuum/fast-syntax-highlighting

# --- Powerlevel10k Theme ---
znap source romkatv/powerlevel10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt inc_append_history share_history hist_ignore_all_dups hist_reduce_blanks

# --- fzf keybindings ---
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

# --- extras ---
eval "$(zoxide init zsh)"

# --- Vi mode and cursor ---
export KEYTIMEOUT=1
bindkey -v

# Change cursor shape for different vi modes
function zle-keymap-select {
  case $KEYMAP in
    vicmd)      echo -ne '\e[1 q';;  # block cursor
    viins|main) echo -ne '\e[5 q';;  # beam cursor
  esac
}
zle -N zle-keymap-select

# Use beam shape cursor on startup and after every command
zle-line-init() {
  echo -ne '\e[5 q'
}
zle -N zle-line-init

# Better vi mode bindings
bindkey '^?' backward-delete-char
bindkey '^H' backward-delete-char
bindkey '^W' backward-kill-word
bindkey '^U' backward-kill-line

# Minimal Widget: Accept 1 character from suggestion
accept-one-char() {
  if [[ -z "$RBUFFER" ]] && [[ -n "$POSTDISPLAY" ]]; then
    BUFFER="${BUFFER}${POSTDISPLAY:0:1}"
    CURSOR=$#BUFFER
  else
    zle forward-char
  fi
}
zle -N accept-one-char
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(accept-one-char)

# Bindings for autosuggestions
bindkey -M viins '\e[C' accept-one-char
bindkey -M emacs '\e[C' accept-one-char
bindkey -M vicmd '\e[C' accept-one-char
bindkey -M viins '^a' autosuggest-accept
bindkey -M emacs '^a' autosuggest-accept

# Export Path
export PATH="$HOME/.local/bin:$PATH"

# cd to current dir after closing yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
