# init global environment variables when login zsh
# Loaded for login shells (both interactive and the rare non-interactive sessions)
#
# ~/.zprofile - Homebrew recommends setting the PATH variable here.
# There's a reason PATH should be set in ~/.zprofile and not the universal ~/.zshenvfile:
# The macOS runs a utility path_helper (from /etc/zprofile) that sets the PATH order before ~/.zprofile is loaded.
#
# If you write automated shell scripts, check and set environment variables in the script.
# Ref: https://mac.install.guide/terminal/zshrc-zprofile

# echo "loading .zprofile"
# export TEST_ZPROFILE="zprofile loaded"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
unset LC_CTYPE
export SSH_KEY_PATH=${HOME}/.ssh/rsa_id

# for linux, to ensure the TERM variable is only set outside of tmux, since
# tmux sets its own terminal.
[ -z "$TMUX" ] && export TERM=xterm-256color

# $KEYTIMEOUT (milliseconds) define the interval that multiple characters key bindings like vv can be triggered.
export KEYTIMEOUT=700
export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
export HISTTIMEFORMAT='%F %T  '

# man page highlight
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline Setting for autosuggestions

export EDITOR=vi
export VISUAL=vi

# TODO: try to source oh-my-zsh in .zprofile to speed up
export ZSH=${HOME}/.oh-my-zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13
#

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

# 3. ide-level env and tools

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
  [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
  export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}"

  # ruby
  export PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:$PATH"

  # llvm
  export PATH="${HOMEBREW_PREFIX}/opt/llvm/bin:$PATH"
  # # setting explicitly the environment variables for CC and CXX to confirm the correct compiler
  export CC="${HOMEBREW_PREFIX}/opt/llvm/bin/clang"
  export CXX="${HOMEBREW_PREFIX}/opt/llvm/bin/clang++"

  export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/llvm/lib"
  export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/llvm/include"

  # java
  # export JAVA_HOME="${HOMEBREW_PREFIX}/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home"
  # export DYLD_LIBRARY_PATH="$JAVA_HOME/lib"
  # export PATH="${JAVA_HOME}/bin:$PATH"
  # # For compilers to find openjdk
  # export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/openjdk/include"

  export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:$PATH"
fi

[ -d "${HOME}/.local/bin" ] && export PATH="${HOME}/.local/bin:${PATH}"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# python
if [ -d "${HOME}/.pyenv/bin" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# golang
export GOPATH=${HOME}/workspace/go
export GO111MODULE=on
export PATH=${GOPATH}/bin:${PATH}

# rust
[ -d "${HOME}/.cargo/bin" ] && export PATH="${HOME}/.cargo/bin:${PATH}"

# export PATH="${HOME}/.deno/bin:${PATH}"
# export PATH="${HOME}/.docker/bin:${PATH}"

[ -e "${HOME}/.iterm2_shell_integration.zsh" ] && source "${HOME}/.iterm2_shell_integration.zsh"
[ -e "${HOME}/.zprofile.local" ] && . "${HOME}/.zprofile.local"

export MOCWORD_DATA=${HOME}/.local/share/mocword/mocword.sqlite
