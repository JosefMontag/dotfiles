# aliases {{{1

alias x="startx" 
alias cat="bat" 
# ensure no alias conflicts
unalias gitdotpush 2>/dev/null

gitdotpush() {
  set -e

  # pick the repo
  local -a GIT
  if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    GIT=(git)
  elif [ -d "$HOME/.dotfiles" ]; then
    GIT=(/usr/bin/git --git-dir="$HOME/.dotfiles" --work-tree="$HOME")
  else
    echo "Not in a git repo, and no ~/.dotfiles bare repo found." >&2
    return 1
  fi

  # stage everything
  "${GIT[@]}" add -A

  # nothing to commit? exit cleanly
  if "${GIT[@]}" diff --cached --quiet; then
    echo "Nothing staged to commit."
    return 0
  fi

  # zsh-style prompt for input
  local msg
  read -r "msg?Commit message: "
  if [ -n "$msg" ]; then
    "${GIT[@]}" commit -m "$msg"
  else
    # fall back to opening $EDITOR like plain `git commit`
    "${GIT[@]}" commit
  fi

  "${GIT[@]}" push
}


# Replace ls with lsd
alias ls='lsd --group-dirs first --icon=auto --color=auto'

# Long listing, human-readable sizes, directories first
alias ll='lsd -lh --group-dirs first --icon=auto --color=auto'

# All files, including dotfiles
alias la='lsd -lha --group-dirs first --icon=auto --color=auto'

# Tree view (depth 2 is a nice default)
alias lt='lsd --tree --depth=2 --group-dirs first --icon=auto --color=auto'

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
