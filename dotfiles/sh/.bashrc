# When  an  interactive  shell  that is not a login shell is started, bash reads and executes commands from ${HOME}/.bashrc, if that file exists.
# user's .bashrc script usually set personal preferences for the command line for interactive shell:
#
# .bashrc contains commands that are specific to the Bash shells.
# Every interactive non-login shell reads .bashrc first.
# Normally .bashrc is the best place to add aliases, set personal preferences( custom prompt, color scheme), and define Bash related functions.

# mode set in .inputrc, to support all program including zsh
# set -o vi
# set -o emacs
# Bash has builtin support with readline and shortcuts, both emacs and vi
# Emacs style (<C-x><C-e> or <C-x>e)
# VI style (v)

# enable globbing
set +o noglob
# enable **/* to recurses all the directories
shopt -s globstar # Bash version >= 4.0
shopt -s extglob
shopt -s failglob

eval "$(pyenv init -)"
eval "$(fzf --bash)"

test -e "${HOME}/.iterm2_shell_integration.bash" && . "${HOME}/.iterm2_shell_integration.bash"
source "${HOME}/.config/broot/launcher/bash/br"
source "${HOME}/.cargo/env"

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
# don't run nvim inside nvim
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  if [ -x "$(command -v nvr)" ]; then
    # echo "using nvr instead nvim"
    alias nvim=nvr
  else
    alias nvim='echo "No nesting nvim!\nUsing:\nnvr [-loOp] <file> [<file>...]"'
  fi
fi

alias rm="rm -i"

alias f="fzf --preview 'bat --color always {}'"
alias fv="fzf -m --preview 'bat --color always {}' --print0 | xargs -0 -o ${EDITOR}"

# tmux session management
alias t="tmux"
alias tn="tmux new -s"
alias ta="tmux attach -t"
alias tl="tmux ls"
alias tx="tmux kill-session -t"
# enable a 256-color Terminal in Linux. For mac, set iTerm2's Profile -> Terminal Emulation -> Report Terminal Type into xterm-256color.
# [ -z "$TMUX" ] && export TERM=xterm-256color
alias tt="tmuxinator"
alias mux="tmuxinator"

alias idea="${HOME}/idea"

[ -e "${HOME}/.local/scripts/.bashrc.local" ] && . "${HOME}/.local/scripts/.bashrc.local"