#!/bin/sh
set -u

SYSOS=$(uname -s)
UNAME_MACHINE=$(uname -m)
DISTRO=""
PM=""

if [ "$SYSOS" = "Darwin" ]; then
  if [ "${UNAME_MACHINE}" = "arm64" ]; then
    # On ARM macOS, this script installs to /opt/homebrew only
    HOMEBREW_PREFIX="/opt/homebrew"
    # On Intel macOS, this script installs to /usr/local only
  else
    HOMEBREW_PREFIX="/usr/local"
  fi
elif [ "$SYSOS" = "Linux" ]; then
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
fi

# --------------------------------------------------------------------------
# check memory and must-have commands
checkPrerequisites() {
  # 0. checking prerequuisites before installation.
  printf "Checking prerequisites before install/uninstall ...\n"

  # check memory size >= 2G, recommand 4G,q
  case $SYSOS in
  "Linux")
    mem_total_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    mem_total_mb=$((mem_total_kb / 1024))
    [ $mem_total_mb -lt 2048 ] && printf "memory size must largger than 2GB, recommend 4G.\n"
    false
    ;;
  "Darwin")
    mem_total_bytes=$(sysctl -n hw.memsize)
    mem_total_mb=$((mem_total_bytes / 1024 / 1024))
    [ $mem_total_mb -lt 2048 ] && printf "memory size must largger than 2GB, recommend 4G.\n"
    false
    ;;
  *)
    printf "%s not supported ...\n" "${SYSOS}"
    false
    ;;
  esac

  if [ "$SYSOS" = "Darwin" ] || [ -d "/home/linuxbrew/.linuxbrew" ]; then
    [ -x "${HOMEBREW_PREFIX}/bin/brew" ] || (
      printf "verify homebrew, bash and zsh. homebrew might be broken, or bash/zsh is not installed correctly via homebrew.\n"
      false
    )
  else
    [ -x /bin/bash ] && [ -x /bin/zsh ] && [ -x /usr/bin/chsh ] || (
      printf "verify bash, zsh and chsh, which might be missing or broken.\n"
      false
    )
  fi
  printf "prerequisites are checked.\n"
}

InstallPrerequisites() {
  checkOsDistro || return

  if [ "$SYSOS" = "Darwin" ]; then
    if [ ! -x "${HOMEBREW_PREFIX}/bin/brew" ]; then
      #  install homebrew silently, bash works, not sh
      ./install_brew.sh
      # bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

      # Option to install XCode Command Line Tools:
      # If you haven't already installed Xcode Command Line Tools,
      # you'll see a message that "The Xcode Command Line Tools will be installed."
      # Press return to continue when prompted by the Homebrew installation script.

      eval "${HOMEBREW_PREFIX}/bin/brew shellenv"
      # check that Homebrew is installed properly.
      brew doctor

      brew analytics off # disable Homebrew’s analytics
      brew update
    else
      eval "${HOMEBREW_PREFIX}/bin/brew shellenv"
      # HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
    fi
    # brew install bash zsh
    # brew Install curl

  elif [ "$SYSOS" = "Linux" ]; then
    # TODO: install brew on linux
    # promot to choose install brew on linux or not
    #
    # if yes, create user linuxbrew and create homebrew
    #
    case $DISTRO in
    "Raspbian" | "Ubuntu")
      sudo apt update && sudo apt upgrade
      sudo apt install -y zsh
      ;;
    "Alpine")
      printf "Important: Enable community repository (/etc/apk/repositories).\n"
      printf "ref: http://mirror.raiolanetworks.com/alpine/v3.21/community \n"

      printf "Important: allow members of the wheel group to use root privileges with doas (/etc/doas.d/doas.conf).\n"
      printf "ref: https://wiki.alpinelinux.org/wiki/Setting_up_a_new_user"

      doas apk update && sudo apk upgrade
      doas add bash zsh shadow
      ;;
    "Arch")
      sudo pacman -S zsh
      ;;
    "*")
      printf "Not yet implemented: install packages on Linux(%s).\n" "$DISTRO"
      false
      ;;
    esac
  else
    printf "Not yet implemented: install packages on OS %s.\n" "$SYSOS"
  fi
}
UninstallPrerequisites() {
  # remove brew, bash/zsh, and linuxbrew
  printf "NOT good idea to remove bash and zsh. \n"
}

installPackagesWithBrew() {
  export HOMEBREW_NO_INSTALL_CLEANUP=1

  # build-essential
  brew update && brew upgrade
  brew install bash zsh
  brew install curl git
  brew install cmake ninja
  brew install openssl@3

  # use system gcc (gcc 9.3.0), not Homebrew gcc (Homebrew GCC 5.5.0_7) 5.5.0
  # however, YouCompleteMe need gcc@5
  # brew install gcc

  # essential tools
  brew install wget bat prettyping diff-so-fancy htop tldr
  brew install fd ripgrep fzf zoxide
  # Install fzf, A command-line fuzzy finder.
  [ -x "$(brew --prefix)/opt/fzf/install" ] && "$(brew --prefix)/opt/fzf/install" --all
  brew install reattach-to-user-namespace

  # development tools
  brew install go node
  # TODO: install node, rust
  # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

  # llvm depends on python3, lld depends on llvm
  brew install python3 python-setuptools
  brew install llvm lld
  brew install luarocks composer
  brew install protobuf
  brew install universal-ctags git-flow gh
  brew install shellcheck
  brew install tmux tmuxinator

  # TODO: move vim, nvim and others to user_packages
  brew install vim
  brew install neovim neovim-remote

  brew install --cask iterm2
  brew install --cask google-chrome
  brew install --cask visual-studio-code

  brew cleanup
}
uninstallPackagesWithBrew() {
  brew uninstall --cask visual-studio-code
  brew uninstall --cask google-chrome
  brew uninstall --cask iterm2

  brew uninstall shellcheck
  brew uninstall tmuxinator tmux
  brew uninstall neovim-remote neovim
  brew uninstall vim
  brew uninstall gh git-flow universal-ctags
  brew uninstall protobuf
  brew uninstall composer luarocks
  brew uninstall node go
  brew uninstall lld llvm
  brew uninstall python-setuptools python3

  brew uninstall reattach-to-user-namespace
  brew uninstall zoxide fzf ripgrep fd
  brew uninstall htop diff-so-fancy prettyping bat wget

  brew uninstall openssl@3
  brew uninstall ninja cmake
  brew uninstall git curl
  # DON'T remove bash/zsh, which disable other user's login
  # brew uninstall zsh bash

  brew cleanup
}

installPackagesWithLinuxBrew() {
  brew install curl git
  # llvm include clangd
  brew install cmake ninja
  brew install openssl@3
  # zlib libtool bzip2 libffi libxml2 libxmlsec1
  # readline sqlite3 xz xclip gettext
  brew install wget bat z prettyping diff-so-fancy htop tldr
  brew install fd ripgrep fzf jq
  brew install universal-ctags git-flow gh

  brew install python3 python-setuptools
  brew install lld llvm
  brew install go node luarocks
  brew install vim neovim neovim-remote
  brew install tmux tmuxinator

  "$(brew --prefix)/opt/fzf/install" --all

  # add extra packages
  brew cleanup
}
uninstallPackagesWithLinuxBrew() {
  brew uninstall tmuxinator tmux
  brew uninstall neovim-remote neovim
  brew uninstall vim
  brew uninstall gh git-flow universal-ctags
  brew uninstall python-setuptools python3
  brew uninstall llvm lld
  brew uninstall luarocks node go
  brew uninstall jq fzf ripgrep fd
  brew uninstall tldr htop diff-so-fancy prettyping z bat wget
  brew uninstall ninja llvm
  brew uninstall git curl
  # DON'T remove bash/zsh, which disable other user's login
  # brew uninstall zsh bash

  brew cleanup
}

installPackagesOnRaspbian() {
  # sudo apt update -y && sudo apt upgrade -y
  sudo apt install -y curl git
  sudo apt install -y xclip fd-find ripgrep fzf openssl
  sudo apt install -y build-essential
  sudo apt install -y cmake autoconf
  sudo apt install -y libtool libtool-bin libreadline-dev libsqlite3-dev libssl-dev libbz2-dev zlib1g-dev libffi-dev
  sudo apt install -y python3 python3-dev golang-go
}
uninstallPackagesOnRaspbian() {
  sudo apt uninstall golang-go python3-dev python3
  sudo apt uninstall libtool libtool-bin libreadline-dev libsqlite3-dev libssl-dev libbz2-dev zlib1g-dev libffi-dev
  sudo apt uninstall autoconf cmake
  sudo apt uninstall build-essential
  sudo apt uninstall openssl fzf ripgrep fd-find xclip
  sudo apt uninstall git curl
}

installPackagesOnUbuntu() {
  sudo apt install -y file procps curl git
  sudo apt install -y xclip ack bat fd-find ripgrep fzf openssl
  sudo apt install -y build-essential
  sudo apt install -y cmake autoconf ninja-build
  sudo apt install -y gettext unzip libpcre3
  sudo apt install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
  sudo apt install -y libtool libtool-bin libreadline-dev libsqlite3-dev libssl-dev libluajit-5.1-dev
  sudo apt install -y libpcre3-dev libssl-dev libbz2-dev zlib1g-dev libgd-dev libffi-dev
  sudo apt install -y clangd python3 golang-go nodejs
  sudo apt install -y spell shellcheck
  sudo apt install -y git-flow gh prettyping jq
  sudo apt install -y tmux
  # python3-dev

  # sudo apt install -y docker-ce docker-ce-cli containerd.io
  # post-installation steps for linux
  # sudo usermod -aG docker "$USER"
  # printf "Log out and log back in so that your group membership is re-evaluated.\n"
  # printf "If testing on a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.\n"
  # printf "On a desktop Linux environment such as X Windows, log out of your session completely and then log back in.\n"
  # printf "On Linux, you can also run the following command to activate the changes to groups:\n"
  # printf " # newgrp docker   \n"
}

uninstallPackagesOnUbuntu() {
  sudo apt uninstall tmux
  sudo apt uninstall git-flow gh prettyping jq
  sudo apt uninstall spell shellcheck

  sudo apt uninstall clangd python3 golang-go nodejs
  sudo apt uninstall libpcre3-dev libssl-dev libbz2-dev zlib1g-dev libgd-dev libffi-dev

  sudo apt uninstall libtool libtool-bin libreadline-dev libsqlite3-dev libssl-dev libluajit-5.1-dev
  sudo apt uninstall apt-transport-https ca-certificates gnupg-agent software-properties-common

  sudo apt uninstall gettext unzip libpcre3
  sudo apt uninstall cmake autoconf ninja-build

  sudo apt uninstall build-essential
  sudo apt uninstall openssl fzf ripgrep fd-find bat ack xclip
  sudo apt uninstall file procps curl git
}

installPackagesOnAlpine() {
  doas apk add git curl
  doas apk add openssl wget unzip gzip xclip ack bat fd ripgrep fzf
  doas apk add build-base cmake linux-headers gcompat
  doas apk add tree-sitter
  doas apk add nodejs npm
  doas apk add clang-dev
  doas apk add rust cargo rust-analyzer
  doas apk add go gopls
  doas apk add python3 py3-pip ruff
  doas apk add ruby
  doas apk add shellcheck jq
  doas apk add git-flow github-cli
  doas apk add neovim neovim-doc luarocks
  doas apk add tmux tmuxinator

  # -------------------------------------------------------------------------
  # Required Build Dependencies for build python3 via pyenv install
  # build-base make g++ cmake and *-dev
  # GNU C Library compatibility layer for musl (for )
  # build-base cmake linux-headers gcompat
  # util-linux-dev zlib-dev bzip2-dev xz-dev libffi-dev ncurses-dev readline-dev
  # openssl-dev gdbm-dev libnsl-dev gettext-dev

  # Alpine uses musl libc instead of glibc.
  # • Alpine uses musl libc, which is lightweight and optimized for minimal environments.
  #   However, it lacks certain symbols and functionality provided by glibc.
  # • The language_server_linux_arm binary is compiled for glibc-based systems
  #   and tries to use features not available in musl libc.

  # codeium (.cache/nvim/codeium/bin/1.20.9/language_server_linux_arm) have been
  # built for a glibc-based system, which causes compatibility issues. gcompat
  # provides basic glibc compatibility on Alpine.

  # nginx
}
uninstallPackagesOnAlpine() {
  doas apk del tmuxinator tmux
  doas apk del luarocks neovim-doc neovim
  doas apk del github-cli git-flow
  doas apk del jq shellcheck
  doas apk del ruby
  doas apk del ruff py3-pip python3
  doas apk del gopls go
  doas apk del rust-analyzer cargo rust
  doas apk del clang-dev
  doas apk del npm nodejs
  doas apk del tree-sitter
  doas apk del gcompat linux-headers cmake build-base
  doas apk del fzf ripgrep fd bat ack xclip gzip unzip wget openssl
  doas apk del curl git
}

installPackagesOnArch() {
  sudo pacman -S --needed --noconfirm git curl
  sudo pacman -S --needed --noconfirm wget unzip gzip xclip bat fd ripgrep fzf openssl
  sudo pacman -S --needed --noconfirm build-base cmake
  sudo pacman -S --needed --noconfirm tree-sitter
}

uninstallPackagesOnArch() {
  sudo pacman -R --needed --noconfirm tree-sitter
  sudo pacman -R --needed --noconfirm build-base cmake
  sudo pacman -R --needed --noconfirm openssl fzf ripgrep fd bat xclip gzip unzip wget
  sudo pacman -R --needed --noconfirm curl git
}

# main entry -----------------------------------------------------------------
InstallSystemPackages() {
  checkOsDistro || return
  checkPrerequisites || return

  printf "Install packages with %s on %s(%s).\n" "$PM" "$SYSOS" "$DISTRO"
  if [ "$SYSOS" = "Darwin" ]; then
    installPackagesWithBrew

  elif [ "$SYSOS" = "Linux" ]; then
    prepareSystemPackages || return
    if [ $PM = "brew" ]; then
      installPackagesWithLinuxBrew
    else
      case $DISTRO in
      "Raspbian")
        installPackagesOnRaspbian
        ;;
      "Ubuntu")
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        sudo add-apt-repository -y "deb https://dl.yarnpkg.com/debian/ stable main"
        # sudo add-apt-repository -y ppa:neovim-ppa/stable
        sudo apt update -y && sudo apt upgrade -y

        installPackagesOnUbuntu
        ;;
      "Alpine")
        installPackagesOnAlpine
        ;;
      "Arch")
        installPackagesOnArch
        ;;
      "*")
        printf "Not yet implemented: install packages on Linux(%s).\n" "$DISTRO"
        false
        ;;
      esac
    fi
  else
    printf "Not yet implemented: install packages on OS %s.\n" "$SYSOS"
  fi
}

UninstallSystemPackages() {
  checkOsDistro || return

  printf "Uninstall packages with %s on %s(%s) .\n" $PM $SYSOS $DISTRO
  if [ "$SYSOS" = "Darwin" ]; then
    uninstallPackagesWithBrew

  elif [ "$SYSOS" = "Linux" ]; then
    if [ "$PM" = "brew" ]; then
      uninstallPackagesWithLinuxBrew
    else
      case $DISTRO in
      "Raspbian")
        uninstallPackagesOnRaspbian
        ;;
      "Ubuntu")
        uninstallPackagesOnUbuntu
        ;;
      "Alpine")
        uninstallPackagesOnAlpine
        ;;
      "Arch")
        uninstallPackagesOnArch
        ;;
      *)
        printf "%s not supported yet." "$DISTRO"
        ;;
      esac
    fi
  else
    printf "%s not supported yet." "$SYSOS"
  fi
}

# ------------------------------------------------------------------------------
# helper functions
#
checkOsDistro() {
  printf "check os distro.\n"
  if [ "${SYSOS}" = "Darwin" ]; then
    DISTRO="Darwin"
    PM="brew"
  elif [ "${SYSOS}" = "Linux" ]; then
    if grep -Eq "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
      DISTRO='CentOS'
      PM='yum'
    elif grep -Eq "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
      DISTRO='RHEL'
      PM='yum'
    elif grep -Eq "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
      DISTRO='Fedora'
      PM='yum'
    elif grep -Eq "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
      DISTRO='Debian'
      PM='apt'
    elif grep -Eq "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
      DISTRO='Ubuntu'
      PM='apt'
    elif grep -Eq "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
      DISTRO='Raspbian'
      PM='apt'
    elif grep -Eq "Arch" /etc/issue || grep -Eq "Arch" /etc/*-release; then
      DISTRO='Arch'
      PM='pacman'
    elif grep -Eq "Alpine" /etc/issue || grep -Eq "Alpine" /etc/*-release; then
      DISTRO='Alpine'
      PM='apk'
    else
      DISTRO='unknow'
      PM=''
      printf "%s is not supported now.\n" "${SYSOS}"
      false
    fi
    # TODO: and need to test brew command exists
    [ -d "/home/linuxbrew/.linuxbrew" ] && PM="brew"
  else
    printf "%s is not supported now.\n" "${SYSOS}"
    false
  fi
  printf "OS distro: %s - %s.\n" "${SYSOS}" "${DISTRO}"
}

# packages installation via brew fails in the following way

# $1 -- command
# $2 -- packages
# example: installPackagesWithCommand "sudo apk add" "$packages_with_apk"
installPackagesWithCommand() {
  echo "$2" | while IFS= read -r packs; do
    packs=$(echo "$packs" | sed 's/^ *//; s/ *$//')
    if [ -n "$packs" ]; then
      printf "installing %s... \n" "$packs"
      eval "$1" "$packs"
    fi
  done
}

# $1 -- command
# $2 -- packages
# example: installPackagesWithCommand "sudo apk del" "$packages_with_apk"
uninstallPackagesWithCommand() {
  rev_packages_list=$(echo "$2" | sed -n '1!G;h;$p')
  echo "$rev_packages_list" | while IFS= read -r packs; do
    packs=$(echo "$packs" | sed 's/^ *//; s/ *$//')
    if [ -n "$packs" ]; then
      # reverse pack list
      rev_packs=$(echo "$packs" | tr ' ' '\n' | sed '1!G;h;$!d' | tr '\n' ' ')
      printf "deleting %s \n" "$rev_packs"
      eval "$1" "$rev_packs"
    fi
  done
}

# ------------------------------------------------------------------------------

# InstallSystemPackages
# UninstallSystemPackages