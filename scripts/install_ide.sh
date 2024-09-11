#!/bin/sh
set -u

installFonts() {
  export PATH="${HOME}/.local/bin:$PATH"
  curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
  # install hack font or other fonts
  getnf -i Hack
}

installVimPlugins() {
  # install vim and nvim plugins
  printf "install my dev env ...\n"
  printf "Install plugins for vim/nvim...\n"

  dotfiles_dir="$(dirname "${PWD}")/dotfiles"

  for CFG_FILE in .editorconfig .czrc .golangci.yml; do
    ln -s "${dotfiles_dir}/sh/${CFG_FILE}" "${HOME}/${CFG_FILE}"
  done

  ln -s "${dotfiles_dir}/vim" "${HOME}/.vim"

  git clone https://github.com/izhujiang/LeoVim.git "${HOME}/repo/LeoVim"
  git clone https://github.com/izhujiang/lvim.git "${HOME}/repo/lvim"
  ln -s "${HOME}/repo/LeoVim" "${HOME}/.config/nvim"
  ln -s "${HOME}/repo/lvim" "${HOME}/.config/lvim"

  if [ -x "$(which vim)" ]; then
    printf "start configing vim plugins...\n"
    vim -E +'silent! PlugInstall --sync' +qall
  fi

  if [ -x "$(which nvim)" ]; then
    printf "start configing nvim plugins...\n"
    # wait 2 minutes for finishing lazy and mason installations
    nvim --headless "+Lazy! install" " +120sleep" +qa

    # install language servers
    # nvim --headless -c "MasonInstall lua-language-server rust-analyzer" -c qall
    # nvim --headless +PlugInstall +qall
  fi

  sleep 1
}

installVimPlugins