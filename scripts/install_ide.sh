#!/bin/sh
set -u

installVimPlugins() {
  # install vim and nvim plugins
  printf "install my dev env ...\n"
  printf "Install plugins for vim/nvim...\n"

  dotfiles_dir="$(dirname "${PWD}")/dotfiles"

  for CFG_FILE in .editorconfig .ycm_extra_conf.py .czrc .golangci.yml; do
    # curl -fsSL --create-dirs -o "${HOME}/${CFG_FILE}" "https://raw.githubusercontent.com/izhujiang/my_env/master/dotfiles/vi/${CFG_FILE}"
    ln -s "${dotfiles_dir}/sh/${CFG_FILE}" "${HOME}/${CFG_FILE}"
  done

  ln -s "${dotfiles_dir}/vim" "${HOME}/.vim"
  ln -s "${HOME}/.vim/.vimrc" "${HOME}/.vimrc"

  # TODO: using repo dynamically
  ln -s "${HOME}/repo/LeoVim" "${HOME}/.config/nvim"
  ln -s "${HOME}/repo/lvim" "${HOME}/.config/lvim"

  if [ -x "$(which vim)" ]; then
    printf "start configing vim plugins...\n"
    vim -E +'silent! PlugInstall --sync' +qall
  fi

  if [ -x "$(which nvim)" ]; then
    printf "start configing nvim plugins...\n"
    # wait 2 minutes for finishing lazy and mason installations
    nvim --headless "+Lazy! install" "+120sleep" +qa
    # nvim --headless +PlugInstall +qall
  fi

  sleep 1
}

installVimPlugins