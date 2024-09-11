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

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
export MANPATH="${HOMEBREW_PREFIX}/share/man:${MANPATH}"
export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH}"
export XML_CATALOG_FILES="${HOMEBREW_PREFIX}/etc/xml/catalog"
export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin:${PATH}"

# for linux, to ensure the TERM variable is only set outside of tmux, since tmux sets its own terminal.
[ -z "$TMUX" ] && export TERM=xterm-256color


export KEYTIMEOUT=1
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

# 3. ide-level env and tools
# golang
export GOPATH=${HOME}/workspace/go
export GO111MODULE=on
export PATH=${GOPATH}/bin:${PATH}
# rust
export PATH="${HOME}/.cargo/bin:${PATH}"
# ruby
export PATH="${HOMEBREW_PREFIX}/opt/ruby/bin:$PATH"
# llvm
export PATH="${HOMEBREW_PREFIX}/opt/llvm/bin:$PATH"

# export LDFLAGS="-L${HOMEBREW_PREFIX}/opt/llvm/lib"
# export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/llvm/include"

# python
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# found static Python library (/Users/hurricane/.pyenv/versions/3.9.2/lib/python3.9/config-3.9-darwin/libpython3.9.a)
# but a dynamic one is required. You must use a Python compiled with the --enable-framework flag. If using pyenv, you need to run the command:
# export PYTHON_CONFIGURE_OPTS="--enable-framework"

# java
export PATH="${HOMEBREW_PREFIX}/opt/openjdk/bin:$PATH"
# For compilers to find openjdk
# export CPPFLAGS="-I${HOMEBREW_PREFIX}/opt/openjdk/include"

# global npm package
export PATH="${HOME}/.local/bin:${PATH}"
export PATH="${HOME}/.deno/bin:${PATH}"
export PATH="${HOME}/.docker/bin:${PATH}"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
test -e "${HOME}/.local/scripts/.zprofile.local" && . "${HOME}/.local/scripts/.zprofile.local"
