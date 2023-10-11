# When  an  interactive  shell  that is not a login shell is started, bash reads and executes commands from ${HOME}/.bashrc, if that file exists.
# user's .bashrc script usually set personal preferences for the command line for interactive shell: custom prompt, specific color scheme...
[ -e "${HOME}/.x_shrc" ] && . "${HOME}/.x_shrc"

export CLICOLOR=1
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# vim-mode for shell
set -o vi
# enable globbing
set +o noglob
# enable **/* to recurses all the directories
shopt -s globstar
shopt -s extglob
shopt -s failglob

test -e "${HOME}/.iterm2_shell_integration.bash" && . "${HOME}/.iterm2_shell_integration.bash"
[ -e "${HOME}/.fzf.bash" ] && . "${HOME}/.fzf.bash"

POWERLINE_BASH=${PY_PACKS_LOC}/powerline/bindings/bash/powerline.sh
test -e "${POWERLINE_BASH}" && . "${POWERLINE_BASH}"

[ -e "${HOME}/.local/scripts/.bashrc.local" ] && . "${HOME}/.local/scripts/.bashrc.local"
