#!/bin/sh
set -u

# prerequuisites has been checked before installation.
# printf "--------------------------------------------\n"
SYSOS=$(uname -s)

installPackagesWithBrew() {
  printf "Updating brew and upgrade formulas ...\n"
  brew update && brew upgrade

  # 1. install all libs, packages and tools
  printf "\nStart installing libs, packages and tools ...\n"
  packages="cmake llvm openssl curl wget git git-flow gh universal-ctags"
  brew install $packages
  # use system gcc (gcc 9.3.0), not Homebrew gcc (Homebrew GCC 5.5.0_7) 5.5.0
  # however, YouCompleteMe need gcc@5
  # brew install gcc

  # luarocks, A package manager for Lua modules.
  packages="go perl node python3 pyenv lua luarocks"
  brew install $packages

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

  if [ "${SYSOS}" = "Linux" ]; then
    # printf "Updating ripgrep 11.0.2 to 12.0.0 failed in homebrew Ubuntu due to asciidoc, install ripgrep later plz ...\n"
    packages="bzip2 libffi libxml2 libxmlsec1 xclip"
    brew install $packages
    # install into ${HOME}/.cargo, for linuxbrew doesn't support rust
    curl https://sh.rustup.rs -sSf | sh -s -- -y -q --no-modify-path
  elif [ "${SYSOS}" = "Darwin" ]; then
    # reattach-to-user-namespace support copy and pasty
    packages="rust reattach-to-user-namespace gnupg gnu-sed"
    brew install $packages
  else
    # printf "reattach-to-user-namespace/xclip ...  not installed on %s ...\n" "${SYSOS}"
  fi

  packages="tmux tmuxinator ripgrep bat fd z broot prettyping diff-so-fancy htop tldr fzf"
  brew install $packages
  # Install fzf, A command-line fuzzy finder.
  if [ "${SYSOS}" = "Darwin" ] || [ "${SYSOS}" = "Linux" ]; then
    "$(brew --prefix)/opt/fzf/install" --all
    printf "\n"
  fi

  # neovim-remote, the client of neovim
  packages="nginx vim neovim neovim-remote"
  # Install vim with python3 support, Pre-installed macOS system Vim does not support Python 3.
  # brew install vim --enable-pythoninterp=dynamic --enable-python3interp=dynamic

  # install lunarvim
  curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | bash /dev/stdin --install-dependencies

  # install platform-specific tools
  if [ "${SYSOS}" = "Darwin" ]; then
    packages="iterm2 google-chrome visual-studio-code
    brew install --cask $packages

  elif [ "${SYSOS}" = "Linux" ]; then
    printf "Install vscode with sudo privilege in GUI mode, following the instruction: \n"
    printf "https://code.visualstudio.com/docs/setup/linux\n"
  else
    printf "vscode only support window, linux and macOS.\n"
  fi
}

installPackagesWithBrew