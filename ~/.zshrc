# aliases {{{1

alias x="startx" 
alias cat="bat" 
alias ..="cd .." 

gitpush() {
  git add -A
  local msg
  read -r "msg?Commit message: "
  [ -n "$msg" ] && git commit -m "$msg" || git commit
  git push
}

# Replace ls with lsd
alias ls='lsd -a --group-dirs first --icon=auto --color=auto'

# All files, including dotfiles
alias ld='lsd -lha --group-dirs first --icon=auto --color=auto'

# Tree view (depth 2 is a nice default)
alias lt='lsd -a --tree --depth=2 --group-dirs first --icon=auto --color=auto'

# zinit {{{1

source ~/.znap/znap.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# --- Core plugins ---
znap source zsh-users/zsh-autosuggestions
znap source zdharma-continuum/fast-syntax-highlighting

# --- Completion system ---
autoload -Uz compinit
# use a fixed dump path (helps avoid “insecure dirs” surprises)
compinit -d ~/.cache/zsh/.zcompdump
zmodload zsh/complist

# Load completion-related plugins AFTER compinit
znap source zsh-users/zsh-completions
znap source Aloxaf/fzf-tab


# Menu selection enabled
zstyle ':completion:*' menu select
unsetopt menu_complete

# Make sure Tab triggers completion in BOTH keymaps
bindkey -M emacs '^I' expand-or-complete
bindkey -M viins '^I'  expand-or-complete

# (Optional) keep fzf-tab lightweight while testing
# zstyle ':fzf-tab:*' fzf-preview ''  # disable heavy previews for now

# --- Powerlevel10k ---
znap source romkatv/powerlevel10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- History ---
HISTFILE=~/.zsh_history   # where history is saved
HISTSIZE=50000
SAVEHIST=50000
setopt inc_append_history share_history hist_ignore_all_dups hist_reduce_blanks

# --- Vi mode ---
bindkey -v
export KEYTIMEOUT=1

# --- fzf keybindings (you already have Ctrl-R via these) ---
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

# --- extras ---
# eval "$(zoxide init zsh)"
# ... your aliases and other stuff above ...

# zinit section with all your plugins
# ...

# Allow comments in interactive mode {{{1
setopt interactivecomments

# --- Vi mode and cursor {{{1
bindkey -v
export KEYTIMEOUT=1

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

