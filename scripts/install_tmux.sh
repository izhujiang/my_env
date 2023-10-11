#!/bin/sh
set -u

configTmux() {
  TMUX_CONF=${HOME}/.tmux.conf
  CURRENTDATE=$(date +"%Y-%m-%d-%H%M")

  if [ -f "${TMUX_CONF}" ]; then
    mv "${TMUX_CONF}" "${TMUX_CONF}.${CURRENTDATE}"
  fi

  curl -fsSL --create-dirs -o "$TMUX_CONF" https://raw.githubusercontent.com/izhujiang/my_env/master/dotfiles/tmux/.tmux.conf

  TMUXINATOR_CONF=${HOME}/.config/tmuxinator
  curl -fsSL --create-dirs -o "$TMUXINATOR_CONF/dev.yml" https://raw.githubusercontent.com/izhujiang/my_env/master/dotfiles/tmux/dev.yml

  # Installs and loads tmux plugins.
  # https://github.com/tmux-plugins/tpm

  if [ ! -d "${HOME}"/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm "${HOME}"/.tmux/plugins/tpm
  else
    cd "${HOME}"/.tmux/plugins/tpm && git pull
  fi
}

configTmux