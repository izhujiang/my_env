# Loaded only for interactive shell sessions. (commands are read from /etc/zshrc and then $ZDOTDIR/.zshrc)
# It is loaded whenever you open a new terminal window or launch a subshell from a terminal window.
# usually set personal preferences for the command line for interactive shell: custom prompt, specific color scheme...
#
# ~/.zshrc - This is the configuration file that most developers use.
# Use it to set aliases and a custom prompt for the terminal window.
# You can also use it to set the PATH (which many people do) but ~/.zprofile is preferred.
# Ref: https://mac.install.guide/terminal/zshrc-zprofile

# echo "loading .zshrc"
# zmodload zsh/zprof
# PS4=$'\\\011%D{%s%6.}\011%x\011%I\011%N\011%e\011'
# exec 3>&2 2>/tmp/zshstart.$$.log
# setopt xtrace prompt_subst

# debug
# cur_sec_and_ns=`gdate '+%s-%N'`
# cur_sec=${cur_sec_and_ns%-*}
# cur_ns=${cur_sec_and_ns##*-}
# cur_timestamp=$((cur_sec*1000+cur_ns/1000000))
# start=$cur_timestamp
# echo 1 $cur_timestamp

ZSH_DISABLE_COMPFIX="true"

# Set name of the theme to load. Optionally, if you set this to "random"
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="kolo"
ZSH_THEME="mortalscumbag"

# Uncomment the following line to use case-eensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-eetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ${HOME}/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ${HOME}/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions forgit extract vi-mode docker)
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-completions vi-mode z)
# set z command alias to zz, avoid the conflix between oh_my_zsh's z plugin and zfz's integration(below).
export _Z_CMD=zz
# oh-my-zsh takes 131ms, and 235ms with plugins
test -e "${ZSH}/oh-my-zsh.sh" && . "${ZSH}/oh-my-zsh.sh"

# tmp=$cur_timestamp
# cur_sec_and_ns=`gdate '+%s-%N'`
# cur_sec=${cur_sec_and_ns%-*}
# cur_ns=${cur_sec_and_ns##*-}
# cur_timestamp=$((cur_sec*1000+cur_ns/1000000))
# echo "source oh-my-zsh" $((cur_timestamp - tmp))

# earse env variables $PAGER and $LESS setted by oh-my-zsh, which cause git branch/diff's output paged by less
unset PAGER
unset LESS

# set -o vi   # mode set in .inputrc, to support all program including zsh
# set -o emacs
# or Alias main keymap to viins keymap
# bindkey -v
# OR
# bindkey -A viins main

# press '<C-x><C-e>' or 'V'/'vv' to start editing with $VISUAL .
# oh_my_zsh vi-mode plugin defines 'vv' and 'v' keybinds
# autoload -U edit-command-line
# bindkey -M vicmd 'v' visual-mode
# bindkey -M vicmd 'vv' edit-command-line
# https://codeberg.org/Mebus/oh-my-zsh/src/branch/master/plugins/vi-mode/README.md#low-keytimeout
# A low $KEYTIMEOUT value (< 15) means that key bindings that need multiple characters, like vv, will be very difficult to trigger.
# $KEYTIMEOUT (milliseconds) set interval of pressing keys, that the multi-character key binding is triggered.
# if vi-mode plugin is not included, bindkey 'v' to edit-command-line instead of 'V'.
bindkey -M vicmd V edit-command-line
bindkey -M viins ^xe edit-command-line
bindkey -M viins ^x^e edit-command-line
bindkey -M emacs ^xe edit-command-line

# useful shell tools
alias q="exit"
alias x="exit"
alias l="ls -la"
alias ll="ls -l"
alias gz="tar -xzvf"
alias tgz="tar -xzvf"
alias bz2="tar -xjvf"

alias gs="git status"
alias ga="git add"
alias gd="git diff"
alias gc="git commit"
alias dv="vi -d"
alias gg="lazygit"

alias cl="clear"
# alias h="history"
alias h="history -i"
alias k="kill -9"
# alias cat='bat'
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias ping='prettyping --nolegend'
alias ctags="\$(brew --prefix)/bin/ctags"

alias python="python3"
alias v=nvim
alias vi=nvim
alias lv=lvim

# 4 don't run nvim inside nvim
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  if [ -x "$(command -v nvr)" ]; then
    # echo "using nvr instead nvim"
    alias nvim=nvr -cc split --remote-wait +'set bufhidden=wipe'
  else
    alias nvim='echo "No nesting nvim!\nUsing:\nnvr [-loOp] <file> [<file>...]"'
  fi
fi

if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
  export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
else
  export VISUAL="vi"
  export EDITOR="vi"
fi

alias rm="rm -i"

alias f="fzf --preview 'bat --color always {}'"
alias fv='fzf -m --preview bat --color always {} --print0 | xargs -0 -o ${EDITOR}'

# tmux session management
alias t="tmux"
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias tx="tmux kill-session -t"

# enable a 256-color Terminal in Linux. For mac, set iTerm2 Profile -> Terminal Emulation -> Report Terminal Type into xterm-256color.
# [ -z "$TMUX" ] && export TERM=xterm-256color
alias tt="tmuxinator"
alias mux="tmuxinator"

alias idea='${HOME}/idea'
z() {
  local dir=$(
    _z 2>&1 |
      fzf --height 40% --layout reverse --info inline \
        --nth 2.. --tac --no-sort --query "$*" \
        --bind 'enter:become:echo {2..}'
  ) && cd "$dir"
}

# fzf version >= 0.48.0
eval "$(fzf --zsh)"

# fzf-git.sh project provides a bunch of key bindings for completing Git objects. You should definitely check it out.

[ -e "${HOME}/.zshrc.local" ] && . "${HOME}/.zshrc.local"
# unsetopt xtrace
# exec 2>&3 3>&-

# zprof
[ -f "${HOME}/.inshellisense/key-bindings.zsh" ] && source "${HOME}/.inshellisense/key-bindings.zsh"

[ -f "${HOME}/.config/broot/launcher/bash/br" ] && source "${HOME}/.config/broot/launcher/bash/br"