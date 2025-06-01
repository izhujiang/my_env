# init global environment variables when login bash
# don't edit .bash_profile, custom with ".bash_profile.local" instead.
#
# 1) In an interactive login shell, Bash first looks for the /etc/profile file.
# If found, Bash reads and executes it in the current shell. As a result,
# /etc/profile sets up the environment configuration for all users.
# 2) Bash then checks if .bash_profile exists in the home directory.
#   -- If it does, then Bash executes .bash_profile in the current shell.
#   -- If Bash doesn’t find .bash_profile, then it looks for .bash_login and .profile,
#      in that order, and executes the first readable file only.
#
# test -e "${HOME}/.env" && . "${HOME}/.env"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
unset LC_CTYPE
export SSH_KEY_PATH=${HOME}/.ssh/rsa_id

# silence warning, If invoke the bash shell while macOS Catalina is configured to use a different shell.
export BASH_SILENCE_DEPRECATION_WARNING=1

SYSOS=$(uname -s)
UNAME_MACHINE="$(uname -m)"
if [ "${SYSOS}" = "Darwin" ]; then
  if [ "${UNAME_MACHINE}" = "arm64" ]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
  fi
elif [ "${SYSOS}" = "Linux" ]; then
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

if [ -n "${HOMEBREW_PREFIX}" ] && [ -d "$HOMEBREW_PREFIX" ]; then
  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
  export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
  export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}"

  # # ruby
  export PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:$PATH"

  # # llvm
  export PATH="${HOMEBREW_PREFIX}/opt/llvm/bin:$PATH"
  # # setting explicitly the environment variables for CC and CXX to confirm the correct compiler
  export CC="${HOMEBREW_PREFIX}/opt/llvm/bin/clang"
  export CXX="${HOMEBREW_PREFIX}/opt/llvm/bin/clang++"

  # export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/llvm/lib"
  # export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/llvm/include"

  # # java
  export PATH="${HOMEBREW_PREFIX}/opt/openjdk/bin:$PATH"
  # For compilers to find openjdk
  # export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/openjdk/include"

  export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:$PATH"
fi

# for linux, to ensure the TERM variable is only set outside of tmux, since tmux sets its own terminal.
[ -z "$TMUX" ] && export TERM=xterm-256color

export EDITOR=vi
export VISUAL=vi

export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
export HISTTIMEFORMAT='%F %T  '

# # fzf
# follow symbolic links, and include hidden files
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'
export FZF_DEFAULT_OPTS=$(echo --multi --height 60% --layout=reverse --border --history=\"${HOME}/.local/share/.fzf-history\" --history-size=1000 --bind=ctrl-n:down,ctrl-j:down,ctrl-p:up,ctrl-k:up,ctrl-h:first,ctrl-l:last,down:next-history,up:previous-history)
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_OPTS='--border --info=inline'
# export FZF_TMUX_OPTS='-d 40%'

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"
# # Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# ripgrep->fzf->vim [QUERY]
rfv() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            vim {1} +{2}     # No selection. Open the current line in Vim.
          else
            vim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
    --bind "start:$RELOAD" --bind "change:$RELOAD" \
    --bind "enter:become:$OPENER" \
    --bind "ctrl-o:execute:$OPENER" \
    --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
    --delimiter : \
    --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
    --preview-window '~4,+{2}+4/3,<80(up)' \
    --query "$*"
)

export PATH="${HOME}/.local/bin:${PATH}"

# 3. ide-level env and tools
# golang
export GOPATH=${HOME}/workspace/go
export GO111MODULE=on
export PATH=${GOPATH}/bin:${PATH}
# rust
[ -d "${HOME}/.cargo/bin" ] && export PATH="${HOME}/.cargo/bin:${PATH}"

SYSOS=$(uname -s)
UNAME_MACHINE="$(uname -m)"
if [ "${SYSOS}" = "Darwin" ]; then
  if [ "${UNAME_MACHINE}" = "arm64" ]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
  else
    # On Intel macOS, this script installs to /usr/local only
    HOMEBREW_PREFIX="/usr/local"
  fi
elif [ "${SYSOS}" = "Linux" ]; then
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

if [ -d "$HOMEBREW_PREFIX" ]; then
  export HOMEBREW_NO_ANALYTICS=1

  # # ruby
  export PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:$PATH"

  # # llvm
  export PATH="${HOMEBREW_PREFIX}/opt/llvm/bin:$PATH"
  # # setting explicitly the environment variables for CC and CXX to confirm the correct compiler
  export CC="${HOMEBREW_PREFIX}/opt/llvm/bin/clang"
  export CXX="${HOMEBREW_PREFIX}/opt/llvm/bin/clang++"

  # export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/llvm/lib"
  # export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/llvm/include"

  # # java
  export PATH="${HOMEBREW_PREFIX}/opt/openjdk/bin:$PATH"
  # For compilers to find openjdk
  # export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/openjdk/include"

  export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:$PATH"

  # ruby
  export PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:$PATH"
  # llvm
  export PATH="${HOMEBREW_PREFIX}/opt/llvm/bin:$PATH"
fi

# python
if [ -d "${HOME}/.pyenv/bin" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# found static Python library (/Users/hurricane/.pyenv/versions/3.9.2/lib/python3.9/config-3.9-darwin/libpython3.9.a)
# but a dynamic one is required. You must use a Python compiled with the --enable-framework flag. If using pyenv, you need to run the command:
# export PYTHON_CONFIGURE_OPTS="--enable-framework"

# global npm package
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export PATH="${HOME}/.docker/bin:${PATH}"

test -e "${HOME}/.bashrc" && . "${HOME}/.bashrc"
test -e "${HOME}/.local/scripts/.bash_profile.local" && . "${HOME}/.local/scripts/.bash_profile.local"