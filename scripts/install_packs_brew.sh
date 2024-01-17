#!/bin/sh
set -u

# prerequuisites has been checked before installation.
# printf "--------------------------------------------\n"
SYSOS=$(uname -s)

installPackagesWithBrew() {
  printf "Updating brew and upgrade formulas ...\n"
  brew update && brew upgrade

  # zsh should be installed as one of prerequisites
  # brew install zsh zplug
  # 1. install all libs, packages and tools
  printf "\nStart installing libs, packages and tools ...\n"

  # use system gcc (gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0), not Homebrew gcc (Homebrew GCC 5.5.0_7) 5.5.0
  # however, YouCompleteMe need gcc@5
  # brew install gcc

  brew install cmake
  # Installing casks is supported only on macOS
  # brew install --cask cmake
  brew install --HEAD universal-ctags/universal-ctags/universal-ctags

  brew install go perl node python3 pyenv

  # build CPython with shared library with --enable-framework required by YouCompleteMe ycmd server and other 3rd party tools, if use python in pyenv.
  # env PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install 3.8.2
  # pyenv global 3.8.2

  # install into ${HOME}/.cargo, for linuxbrew doesn't support rust
  curl https://sh.rustup.rs -sSf | sh -s -- -y -q --no-modify-path

  if [ "${SYSOS}" = "Linux" ]; then
    # printf "Updating ripgrep 11.0.2 to 12.0.0 failed in homebrew Ubuntu due to asciidoc, install ripgrep later plz ...\n"
    brew install bzip2 libffi libxml2 libxmlsec1 xclip
  elif [ "${SYSOS}" = "Darwin" ]; then
    # reattach-to-user-namespace support copy and pasty
    brew install reattach-to-user-namespace
    brew install gnupg gnu-sed
    brew install iterm2
  else
    printf "reattach-to-user-namespace/xclip ...  not installed on %s ...\n" "${SYSOS}"
  fi

  brew install curl wget git tldr gd
  brew install tmux tmuxinator

  # install rust and cargo before ripgrep
  brew install ripgrep bat fd z broot autojump
  brew install ncdu prettyping htop graphviz lf

  brew install fzf
  # Install fzf, A command-line fuzzy finder.
  if [ "${SYSOS}" = "Darwin" ] || [ "${SYSOS}" = "Linux" ]; then
    "$(brew --prefix)/opt/fzf/install" --all
    printf "\n"
  fi

  # install nginx, or install nginx manually from sourcecode, and fix --with-http_ssl_module bug referring to https://www.widlabs.com/article/mac-os-x-nginx-compile-symbol-not-found-for-architecture-x86_64
  brew install luarocks nginx

  # install vim with python3 support
  # brew install vim --enable-pythoninterp=dynamic --enable-python3interp=dynamic
  brew install vim neovim

  # install lunarvim
  curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | bash /dev/stdin --install-dependencies

  # install platform-specific tools
  if [ "${SYSOS}" = "Darwin" ]; then
    brew install --cask iterm2
    brew install --cask google-chrome
    brew install --cask visual-studio-code

    # install other useful tools
    # brew cask install alfred
  elif [ "${SYSOS}" = "Linux" ]; then
    printf "Install vscode with sudo privilege in GUI mode, following the instruction: \n"
    printf "https://code.visualstudio.com/docs/setup/linux\n"
  else
    printf "vscode only support window, linux and macOS.\n"
  fi
}

installPackagesWithBrew