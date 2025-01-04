#!/bin/sh
set -u

SYSOS=$(uname -s)
UNAME_MACHINE=$(uname -m)
DISTRO=""
PM=""
SYS_PACKAGES=""

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

# defines packages to be installed
prepareSystemPackages() {
  if [ "${SYSOS}" = "Darwin" ]; then
    SYS_PACKAGES="
      curl git openssl
      llvm cmake ninja
      readline sqlite3 xz zlib
      luajit gettext libtool
      reattach-to-user-namespace gnupg gnu-sed
      go perl node python3 pyenv luarocks
      rust
      tmux tmuxinator ripgrep bat fd z broot prettyping diff-so-fancy htop tldr fzf git-flow gh universal-ctags
      clangd
      vim neovim neovim-remote
      nginx
    "
  elif [ "${SYSOS}" = "Linux" ]; then
    if [ $PM = "brew" ]; then
      SYS_PACKAGES="
        curl git openssl
        llvm cmake ninja
        zlib libtool bzip2 libffi libxml2 libxmlsec1
        readline sqlite3 xz  xclip gettext
        go perl node python3 pyenv luarocks
        tmux tmuxinator ripgrep bat fd z broot prettyping diff-so-fancy htop tldr fzf git-flow gh universal-ctags
        clangd
        vim neovim neovim-remote
        nginx
      "
    else
      case $DISTRO in
      "Raspbian")
        # TODO: remove non-necessary *-devs
        SYS_PACKAGES="
          curl git
          xclip fzf fd-find ripgrep openssl
          build-essential
          cmake autoconf
          libtool libtool-bin libreadline-dev libsqlite3-dev libssl-dev libbz2-dev zlib1g-dev libffi-dev
          python3 python3-dev golang-go
        "
        ;;
      "Ubuntu")
        SYS_PACKAGES="
          git file procps curl
          xclip ack fzf bat fd-find ripgrep openssl
          openssh-server
          build-essential
          cmake autoconf ninja-build
          gettext unzip libpcre3
          apt-transport-https ca-certificates gnupg-agent software-properties-common
          libtool libtool-bin libreadline-dev libsqlite3-dev libssl-dev libluajit-5.1-dev
          libpcre3-dev libssl-dev libbz2-dev zlib1g-dev libgd-dev libffi-dev
          clangd
          python3 python3-dev golang-go nodejs
          tmux
          git-flow gh prettyping jq
          shell spell shellcheck net-tools
          nginx
        "
        ;;
      "Alpine")
        # doas or sudo
        SYS_PACKAGES="
          git curl wget unzip gzip composer xclip ack bat fd ripgrep openssl
          build-base cmake linux-headers gcompat
          tree-sitter
          nodejs npm
          clang-dev
          rust cargo rust-analyzer
          go gopls
          python3 py3-pip ruff
          ruby
          lua-language-server
          shellcheck jq
          git-flow github-cli
          neovim neovim-doc py3-pynvim luarocks
          net-tools tmux tmuxinator
          fzf
        "
        ;;
      "Arch")
        SYS_PACKAGES="
          git curl file openssh-server
          base-devel
        "
        ;;

      *)
        printf "Distro %s is not supported. \n" "$DISTRO"
        false
        ;;
      esac
    fi
  else
    printf "Not yet implemented: install packages on OS %s.\n" "$SYS_PACKAGES"
    false
  fi
}

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
    [ -x "${HOMEBREW_PREFIX}/bin/brew" ] && [ -x "${HOMEBREW_PREFIX}/bin/bash" ] && [ -x "${HOMEBREW_PREFIX}/bin/zsh" ] || (
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

      # If you haven't already installed Xcode Command Line Tools,
      # you'll see a message that "The Xcode Command Line Tools will be installed."
      # Press return to continue when prompted by the Homebrew installation script.

      eval "${HOMEBREW_PREFIX}/bin/brew shellenv"
      # check that Homebrew is installed properly.
      brew doctor

      brew analytics off # disable Homebrew’s analytics
      brew tap homebrew/cask
      brew tap go-delve/delve
      brew tap mongodb/brew
      # brew tap pivotal/tap
      brew tap golangci/tap
      brew update
    else
      eval "${HOMEBREW_PREFIX}/bin/brew shellenv"
      # HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
    fi
    brew install bash zsh

  elif [ "$SYSOS" = "Linux" ]; then
    # TODO: install brew on linux
    # promot to choose install brew on linux or not
    #
    # if yes, create user linuxbrew and create homebrew
    #
    case $DISTRO in
    "Raspbian" | "Ubuntu")
      sudo apt update && sudo apt upgrade
      sudo add zsh
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
  printf "NOT good idea to remove homebrew, bash and zsh. \n"
}

# main entry -----------------------------------------------------------------
InstallSystemPackages() {
  checkOsDistro || return
  prepareSystemPackages || return

  printf "Install packages with %s on %s(%s).\n" "$PM" "$SYSOS" "$DISTRO"
  if [ "$SYSOS" = "Darwin" ]; then
    checkPrerequisites || return

    brew update && brew upgrade
    installPackagesWithCommand "brew install" "$SYS_PACKAGES"
    # brew link --force gettext
    # Install fzf, A command-line fuzzy finder.
    "$(brew --prefix)/opt/fzf/install" --all

    # use system gcc (gcc 9.3.0), not Homebrew gcc (Homebrew GCC 5.5.0_7) 5.5.0
    # however, YouCompleteMe need gcc@5
    # brew install gcc
    # install platform-specific tools
    brew install --cask iterm2 google-chrome visual-studio-code

    brew cleanup
  elif [ "$SYSOS" = "Linux" ]; then
    if [ $PM = "brew" ]; then
      checkPrerequisites || return

      # brew update && brew upgrade
      installPackagesWithCommand "brew install" "$SYS_PACKAGES"
      # brew link --force gettext
      # Install fzf, A command-line fuzzy finder.
      "$(brew --prefix)/opt/fzf/install" --all

      # add extra packages
      printf "Install vscode with sudo privilege in GUI mode, follow the instruction: \n"
      printf "https://code.visualstudio.com/docs/setup/linux\n"
      printf "vscode only support window, linux and macOS.\n"
      brew cleanup
    else
      case $DISTRO in
      "Raspbian")
        checkPrerequisites || return

        # sudo apt update -y && sudo apt upgrade -y
        installPackagesWithCommand "sudo apt install" "$SYS_PACKAGES"
        ;;
      "Ubuntu")
        checkPrerequisites || return

        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        sudo add-apt-repository -y "deb https://dl.yarnpkg.com/debian/ stable main"
        # sudo add-apt-repository -y ppa:neovim-ppa/stable

        sudo apt update -y && sudo apt upgrade -y
        installPackagesWithCommand "sudo apt install" "$SYS_PACKAGES"

        # sudo apt install -y docker-ce docker-ce-cli containerd.io
        # post-installation steps for linux
        # sudo usermod -aG docker "$USER"
        # printf "Log out and log back in so that your group membership is re-evaluated.\n"
        # printf "If testing on a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.\n"
        # printf "On a desktop Linux environment such as X Windows, log out of your session completely and then log back in.\n"
        # printf "On Linux, you can also run the following command to activate the changes to groups:\n"
        # printf " # newgrp docker   \n"

        ;;
      "Alpine")
        checkPrerequisites || return

        # don't update system which requires input password, update should be done when installing prerequuisites
        #
        # doas apk update && doas apk upgrade
        installPackagesWithCommand "doas apk add" "$SYS_PACKAGES"

        # apk -------------------------------------------------------------------------
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
        # gcompat

        # libtool libtool-bin
        # libpcre3 libpcre3-dev

        # use built-in package manager instead of pip
        # sudo apk add py3-pip py3-setuptools py3-pynvim

        # languages runtime, LSP and tools
        # lua and luajit installed by neovim

        # nginx

        ;;
      "Arch")
        checkPrerequisites || return

        installPackagesWithCommand "sudo pacman -S" "$SYS_PACKAGES"
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
  prepareSystemPackages || return

  printf "Uninstall packages with %s on %s(%s) .\n" $PM $SYSOS $DISTRO
  if [ "$SYSOS" = "Darwin" ]; then
    brew uninstall --cask iterm2 google-chrome visual-studio-code
    uninstallPackagesWithCommand "brew uninstall" "$SYS_PACKAGES"

  elif [ "$SYSOS" = "Linux" ]; then
    if [ "$PM" = "brew" ]; then
      uninstallPackagesWithCommand "brew uninstall" "$SYS_PACKAGES"
    else
      case $DISTRO in
      "Ubuntu" | "Raspbian")
        uninstallPackagesWithCommand "sudo apt uninstall" "$SYS_PACKAGES"
        ;;
      "Alpine")
        uninstallPackagesWithCommand "doas apk del" "$SYS_PACKAGES"
        ;;
      "Arch")
        uninstallPackagesWithCommand "sudo pacman -Rs" "$SYS_PACKAGES"
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
    [ -d "/home/linuxbrew/.linuxbrew" ] && PM="brew" || true
  else
    printf "%s is not supported now.\n" "${SYSOS}"
    false
  fi
  printf "OS distro: %s - %s.\n" "${SYSOS}" "${DISTRO}"
}

# InstallSystemPackages
# UninstallSystemPackages