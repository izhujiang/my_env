# init global environment variables when login zsh
# don't edit .zprofile, custom with ".zprofile.local" instead.
# echo "loading .zprofile"
# export TEST_ZPROFILE="zprofile loaded"

# man page highlight
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline Setting for autosuggestions


# todo: try to source oh-my-zsh in .zprofile to speed up, but how about start zsh from bash
# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=blue'

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13
#
# zplug takes 270ms
# export ZPLUG_HOME=/usr/local/opt/zplug
# source $ZPLUG_HOME/init.zsh
# source ${HOME}/.zplug
# reduce the delay of switching from "Insert" to "Normal" mode into 0.1 seconds.
export KEYTIMEOUT=1
test -e "${HOME}/.x_profile" && . "${HOME}/.x_profile"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
test -e "${HOME}/.local/scripts/.zprofile.local" && . "${HOME}/.local/scripts/.zprofile.local"
