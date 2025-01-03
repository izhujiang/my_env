#!/bin/bash
set -u
installPackagesWithApt() {
  sudo apt update -y && sudo apt upgrade -y

  # To be able to use add-apt-repository, need to install software-properties-common
  sudo apt install -y apt-transport-https ca-certificates gnupg-agent software-properties-common

  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  sudo add-apt-repository -y "deb https://dl.yarnpkg.com/debian/ stable main"
  sudo add-apt-repository -y ppa:longsleep/golang-backports
  # sudo add-apt-repository -y ppa:neovim-ppa/stable
  sudo apt update -y

  sudo apt install -y build-essential procps curl file wget zsh git git-flow gh
  sudo apt install -y cmake autoconf xclip ack fzf bat fd-find ripgrep spell shellcheck net-tools openssh-server
  sudo apt install -y libtool libtool-bin libbz2-dev zlib1g-dev libgd-dev libreadline-dev libsqlite3-dev libssl-dev libffi-dev
  sudo apt install -y libpcre3 libpcre3-dev openssl libssl-dev libcanberra-gtk-module
  sudo apt install -y tmux prettyping jq

  sudo apt install -y golang-go python3 python3-dev ruby ruby-html2haml ruby-dev default-jdk
  curl https://pyenv.run | bash

  # TODO: move to post_install and before install extra packages
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  pyenv init -

  # restart shell: for the PATH changes to take effect.
  exec "$SHELL"
  # pyenv latest -k 3 | xargs pyenv install
  PYTHON_LATEST_VERSION=$(pyenv latest -k 3)
  pyenv install $PYTHON_LATEST_VERSION
  pyenv global $PYTHON_LATEST_VERSION

  # include rustc, cargo and rust-gdb
  curl https://sh.rustup.rs -sSf -y | sh -s -- -y
  . "${HOME}/.cargo/env"

  # install nodejs LTS via nvm
  git clone https://github.com/nvm-sh/nvm.git "${HOME}/.nvm"
  source "${HOME}/.nvm/nvm.sh"
  nvm install --lts

  # echo "Download Oracle JDK from oracle website and install it to ${HOME}/java like ${HOME}/java/jdk-10, if you prefer oracle jdk instead."
  # curl -s "https://get.sdkman.io" | bash
  # source "/home/hurricane/.sdkman/bin/sdkman-init.sh"
  # sdk install gradle

  printf "You may install nginx from sourcecode instead.\n"
  sudo apt install -y nginx

  # sudo apt install -y docker-ce docker-ce-cli containerd.io

  # post-installation steps for linux
  # sudo usermod -aG docker "$USER"
  # printf "Log out and log back in so that your group membership is re-evaluated.\n"
  # printf "If testing on a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.\n"
  # printf "On a desktop Linux environment such as X Windows, log out of your session completely and then log back in.\n"
  # printf "On Linux, you can also run the following command to activate the changes to groups:\n"
  # printf " # newgrp docker   \n"

  # Vim Variant: vim-nox is designed for those who prefer to work in the terminal without the distraction of a graphical interface.
  # The package also offers the power of scripting languages like Perl, Python, Ruby, and TCL.
  sudo apt install vim-nox

  # sudo apt install -y vim neovim
  sudo apt install -y gettext
  git clone https://github.com/neovim/neovim.git ${HOME}/workspace/neovim
  cd ${HOME}/workspace/neovim
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd -
}

postInstallWithApt() {
  # post-installation
  test -d "${HOME}/.local/bin" || mkdir "${HOME}/.local/bin"
  ln -s /usr/bin/batcat "${HOME}/.local/bin/bat"
  ln -s /usr/bin/fdfind "${HOME}/.local/bin/fd"

  test -d "${HOME}/.local/scripts" || mkdir "${HOME}/.local/scripts"
  # enable fzf keybindings and fuzzy auto-completion for zsh and bash
  {
    echo "source /usr/share/doc/fzf/examples/key-bindings.zsh"
    echo "source /usr/share/doc/fzf/examples/completion.zsh"
  } >>"${HOME}/.local/scripts/.zshrc.local"

  {
    echo "source /usr/share/doc/fzf/examples/key-bindings.bash"
    echo "source /usr/share/doc/fzf/examples/completion.bash"
  } >>"${HOME}/.local/scripts/.bashrc.local"
}

installPackagesWithApt
postInstallWithApt