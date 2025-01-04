#!/bin/sh
set -u

SYSOS=$(uname -s)
DISTRO=""

# main entry -----------------------------------------------------------------
SetupUserEnv() {
  checkOsDetail || return

  installZshPlugins
  installFonts

  if [ "${SYSOS}" = "Darwin" ]; then
    installGolangPackages
    installNodejsPackages
    installCustomPython
    installPythonPackages
    installRustPackages

    # Pre-installed macOS system Vim does not support Python 3.
    installCustomVim
    installVimPlugins

    installNeovimPlugins
    # TODO: install lunarvim
    # curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | bash /dev/stdin --install-dependencies

    installVscodePlugins
  elif [ "${SYSOS}" = "Linux" ]; then
    case $DISTRO in
    "Raspbian")
      installGolangPackages
      installCustomVim
      installVimPlugins
      ;;
    "Ubuntu")
      # to ensure LuaJIT is installed and properly configured before building Neovim from source.
      # sudo apt install -y build-essential cmake libtool-bin ninja-build gettext curl unzip git libluajit-5.1-dev

      installGolangPackages
      installCustomRust
      installRustPackages
      installCustomPython
      installPythonPackages
      installNodejsPackages

      # Vim Variant: vim-nox is designed for those who prefer to work in the
      # terminal without the distraction of a graphical interface.
      # The package also offers the power of scripting languages like Perl, Python, Ruby, and TCL.
      # sudo apt install vim-nox
      installCustomVim
      installVimPlugins

      installCustomNeovim
      installNeovimPlugins
      ;;
    "Alpine")
      installGolangPackages
      installRustPackages
      installNodejsPackages
      InstallRubyPackages

      installNeovimPlugins
      ;;
    "Arch")
      printf "TODO: install user_packages on Arch \n"

      false
      ;;
    "*")
      printf "Not yet implemented: install packages on OS %s.\n" "$SYS_PACKAGES"

      false
      ;;
    esac
  else
    printf "Not yet implemented: install packages on OS %s.\n" "$SYS_PACKAGES"
    false
  fi

  setupTmux
  # # fzf version >= 0.48.0
  # fzf --zsh >"${HOME}/.fzf"
  configShell
  configGitClient "Jiang Zhu" "m.zhujiang@gmail.com"
  setupSSH "m.zhujiang@gmail.com"

  switchShell "zsh"
  printf "Well done. Enjoy your journey!\n"
}

CleanUserEnv() {
  printf "Cleanup user %s's environment.\n" "$(whoami)"
  checkOsDetail || return
  backupDotFiles

  cleanSSH
  removeDotfiles
  cleanTmux

  if [ "${SYSOS}" = "Darwin" ]; then
    # remove luarvim
    uninstallVscodePlugins
    uninstallNeovimPlugins
    uninstallVimPlugins
    uninstallCustomVim

    uninstallRustPackages
    uninstallPythonPackages
    uninstallCustomPython
    uninstallNodejsPackages
    uninstallGolangPackages

  elif [ "${SYSOS}" = "Linux" ]; then
    case $DISTRO in
    "Raspbian")
      uninstallVimPlugins
      uninstallCustomVim
      uninstallGolangPackages
      ;;
    "Ubuntu")
      installNeovimPlugins
      installCustomNeovim
      installVimPlugins
      installCustomVim

      uninstallNodejsPackages
      uninstallPythonPackages
      uninstallCustomPython
      uninstallRustPackages
      uninstallCustomRust
      uninstallGolangPackages
      ;;
    "Alpine")
      uninstallNeovimPlugins

      uninstallRubyPackages
      uninstallNodejsPackages
      uninstallRustPackages
      uninstallGolangPackages
      ;;
    "Arch")
      printf "Uninstall packages with pacman.\n"

      ;;

    "*")
      printf "Not yet implemented on %s(%s).\n" "$SYS_PACKAGES" "$DISTRO"
      ;;
    esac
  else
    printf "Not yet implemented on %s(%s).\n" "$SYS_PACKAGES" "$DISTRO"
  fi

  # uninstallFonts
  uninstallZshPlugins
  cleanCache

  # restore default shell
  case "${DISTRO}" in
  "Alpine")
    switchShell "ash"
    ;;
  "*")
    switchShell "bash"
    ;;
  esac
}

installZshPlugins() {
  printf "Install oh-my-zsh and plugins for zsh ...\n"
  # install zsh plugins
  export ZSH="${HOME}/.oh-my-zsh"
  export ZSH_CUSTOM="${ZSH}/custom"

  if [ -e "${ZSH}/.oh-my-zsh.sh" ]; then
    return
  fi

  # sh -c "$(curl -fsSL https: //raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) "

  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --skip-chsh --unattended --keep-zshrc"

  # manage zsh_plugins with zplug instead.
  for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-completions; do
    if [ ! -d "${ZSH_CUSTOM}"/plugins/${plugin} ]; then
      # git clone git://github.com/zsh-users/${plugin} "${ZSH_CUSTOM}"/plugins/${plugin}
      git clone https://github.com/zsh-users/${plugin}.git "${ZSH_CUSTOM}"/plugins/${plugin}
    else
      printf "update %s " $plugin
      cd "${ZSH_CUSTOM}"/plugins/${plugin} && git pull
      cd - || return
    fi
  done
}
uninstallZshPlugins() {
  printf "Uninstall oh-my-zsh and plugins for zsh ...\n"
  rm -rf "${HOME}/.oh-my-zsh"
  unset ZSH_CUSTOM
  unset ZSH
}

# -----------------------------------------------------------------------------
# python_3rd_packages="pip setuptools pynvim ruff imgcat cmake-language-server"
installPythonPackages() {
  # install python 3rd party packages
  python3 -m ensurepip --upgrade
  python3 -m pip install --upgrade pip
  printf "Install 3d-party packages for python...... \n"
  printf "Current pip3: %s\n" "$(which pip3)"
  # pip3 install -U "$python_3rd_packages"
  # pip3 install -U pip
  pip3 install -U setuptools
  pip3 install -U pynvim
  pip3 install -U ruff
  # pip3 install -U imgcat
  # pip3 install -U cmake-language-server
}
uninstallPythonPackages() {
  # install python 3rd party packages
  printf "uninstall 3d-party packages for python...... \n"
  # rev_python_3rd_packages=$(echo "$python_3rd_packages" | tr ' ' '\n' | sed '1!G;h;$!d' | tr '\n' ' ')
  # eval pip3 uninstall "$rev_python_3rd_packages"
  # pip3 uninstall cmake-language-server
  # pip3 uninstall imgcat
  pip3 uninstall ruff
  pip3 uninstall pynvim
  pip3 uninstall setuptools
  # pip3 uninstall pip
}

# -----------------------------------------------------------------------------
InstallRubyPackages() {
  # install gem 3d party packages
  printf "Install 3d-party packages for ruby ...\n"
  # gem install html2haml
  # gem install sass

  # ruby provider for neovim
  # gem install neovim
}
uninstallRubyPackages() {
  printf "uninstall 3d-party packages for ruby ...\n"
}

# -----------------------------------------------------------------------------
installNodejsPackages() {
  # install node.js 3d party packages
  printf "Install nodejs 3d-party packages ...\n"

  printf "change npm global repository where node_modules stored ...\n"
  npm config set prefix "${HOME}/.local"
  [ -d "${HOME}/.local/lib" ] || mkdir -p "${HOME}/.local/lib"

  # npm install -g npm
  # eval npm install -g "$node_3rd_packages"
  npm install -g neovim
  npm install -g typescript
  # npm install -g serve
  # npm install -g eslint js-beautify
  # npm install -g lighthouse
  # npm install -g commitizen conventional-changelog cz-conventional-changelog

  # @microsoft/inshellisense # IDE style command line auto complete by microsoft
  #  git commit message guidelines:
  # https://gist.github.com/abravalheri/34aeb7b18d61392251a2
  # https://github.com/commitizen/cz-cli

}

uninstallNodejsPackages() {
  # install node.js 3d party packages
  printf "Uninstall nodejs 3d-party packages ...\n"

  # rev_node_3rd_packages=$(echo "$node_3rd_packages" | tr ' ' '\n' | sed '1!G;h;$!d' | tr '\n' ' ')
  # eval npm uninstall -g "$rev_node_3rd_packages"
  # npm uninstall -g commitizen conventional-changelog cz-conventional-changelog
  # npm uninstall -g lighthouse
  # npm uninstall -g eslint js-beautify
  # npm uninstall -g serve
  npm uninstall -g typescript
  npm uninstall -g neovim

  # TODO: rm .npm
  # rm -rf "${HOME}/.npm"
  rm -f "${HOME}/.npmrc"
}
#
# -----------------------------------------------------------------------------
installRustPackages() {
  printf "Install 3d-party packages for rust ...\n"
  # cargo install selene
  cargo install selene
  cargo install stylua
}
uninstallRustPackages() {
  printf "Uninstall 3d-party packages for rust ...\n"
  # Mason don't support selene on alpine
  cargo uninstall stylua
  cargo uninstall selene

  rm -rf "${HOME}/.cargo"
}

# -----------------------------------------------------------------------------
installGolangPackages() {
  export GOPATH="$HOME/workspace/go"
  # fix issure: cannot use path@version syntax in GOPATH mode
  export GO111MODULE=on
  printf "Install tools and packages to GOPATH: %s for golang ...\n" "${GOPATH}"

  go install github.com/acroca/go-symbols@latest
  go install github.com/client9/misspell/cmd/misspell@latest
  go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
  go install github.com/fatih/gomodifytags@latest
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
  go install github.com/goreleaser/goreleaser@latest
  go install github.com/haya14busa/goplay/cmd/goplay@latest
  go install github.com/jesseduffield/lazygit@latest
  go install github.com/josharian/impl@latest
  go install github.com/kisielk/errcheck@latest
  go install github.com/mdempsky/gocode@latest
  go install github.com/mrtazz/checkmake/cmd/checkmake@latest
  go install github.com/nsf/gocode@latest
  go install github.com/ramya-rao-a/go-outline@latest
  go install github.com/rogpeppe/godef@latest
  go install github.com/sqs/goreturns@latest
  go install github.com/stamblerre/gocode@latest
  go install github.com/zmb3/goaddimport@latest
  go install github.com/zmb3/gogetdoc@latest
  go install golang.org/x/lint/golint@latest
  go install golang.org/x/tools/cmd/godoc@latest
  go install golang.org/x/tools/cmd/goimports@latest
  go install golang.org/x/tools/cmd/gorename@latest
  go install golang.org/x/tools/cmd/stringer@latest
  go install golang.org/x/tools/gopls@latest

  # go packages
  #'go get' is no longer supported outside a module.
  # go get -- add dependencies to current module and install them
  # go get -u github.com/cweill/gotests/...
}

uninstallGolangPackages() {
  printf "Uninstall tools and packages: %s...\n" "${GOPATH}"
  # TODO: rm ${GOPATH}/bin/${file}

  [ -z "${GOPATH}" ] && GOPATH="${HOME}/workspace/go"
  go clean -cache

  [ -d "${HOME}/workspace/go" ] && (
    find "${HOME}/workspace/go/pkg/mod" -type d -exec chmod +w {} \;
    rm -rf "${HOME}/workspace/go"
  )
  [ -d "${HOME}/.config/go" ] && rm -rf "${GOPATH}/.config/go"
}

# -----------------------------------------------------------------------------
installVscodePlugins() {
  command -v code >/dev/null 2>&1 || return 1

  printf "Install extension for code ...\n"
  code --force --install-extension bmuskalla.vscode-tldr
  code --force --install-extension vscodevim.vim

  SYSOS=$(uname -s)
  if [ "${SYSOS}" = "Darwin" ]; then
    # To enable key-repeating, ref https://github.com/VSCodeVim/Vim
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  fi

  printf "Todo: install more extensions for vscode.\n"
}

installFonts() {
  # getnf, A better way to install Nerd Fonts
  if [ ! -x "$(which getnf)" ]; then
    [ -d "${HOME}/.local/bin" ] || mkdir -p "${HOME}/.local/bin"
    export PATH="${HOME}/.local/bin:$PATH"
    curl -fsSL https://raw.githubusercontent.com/getnf/getnf/main/install.sh | bash
  fi

  # install hack font or other fonts
  getnf -i Hack
}

installCustomVim() {
  [ -d "${HOME}/workspace}" ] || mkdir -p "${HOME}/workspace"
  # install latest vim
  git clone https://github.com/vim/vim.git "${HOME}/workspace/vim"
  cd "${HOME}/workspace/vim/src" || return
  ./configure --enable-python3interp
  make && make test && sudo make install
  cd - || return
}

installVimPlugins() {
  # install vim plugins
  printf "Install vim plugins...\n"

  [ -d "${HOME}/.vim" ] || mkdir -p "${HOME}/.vim"
  for CFG_FILE in vimrc plugins.vim filetype.vim; do
    cp ../dotfiles/vim/${CFG_FILE} "${HOME}/.vim/${CFG_FILE}"
  done

  if [ -x "$(which vim)" ]; then
    vim -E +'silent! PlugInstall --sync' +qall
  fi
}

uninstallVimPlugins() {
  printf "Uninstall vim plugins...\n"

  if [ -x "$(which vim)" ]; then
    printf "remove vim plugins...\n"
    vim -E +'silent! PlugUninstall --sync' +60sleep +qa
  fi

  rm -rf "${HOME}/.local/share/vim/plugged"
  rm -rf "${HOME}/.vim"
}

installCustomNeovim() {
  git clone https://github.com/neovim/neovim.git "${HOME}/workspace/neovim"
  cd "${HOME}/workspace/neovim" || return
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd - || return
}

installNeovimPlugins() {
  # install nvim plugins
  printf "Install nvim plugins...\n"

  if [ ! -d "${HOME}/repo/LeoVim" ]; then
    git clone https://github.com/izhujiang/LeoVim.git "${HOME}/repo/LeoVim"
  else
    cd "${HOME}/repo/LeoVim" || return
    git pull
    cd - || return
  fi

  # maybe symbolic link is better an option
  # if [ ! -d "${HOME}/.config/nvim" ]; then
  #   cp -r "${HOME}/repo/LeoVim" "${HOME}/.config/nvim"
  # fi
  ln -s "${HOME}/repo/LeoVim" "${HOME}/.config/nvim"

  if [ ! -d "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/" ]; then
    mkdir -p "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/"

    if [ "${SYSOS}" = "Linux" ]; then
      [ -x /usr/bin/luarocks-5.1 ] && ln -s /usr/bin/luarocks-5.1 "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks"
      [ -x /usr/bin/lua ] && ln -s /usr/bin/lua "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/lua"
    elif [ "${SYSOS}" = "Darwin" ]; then
      [ -x "${HOMEBREW_PREFIX}/bin/luarocks-5.1" ] && ln -s "${HOMEBREW_PREFIX}/bin/luarocks-5.1" "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks"
      [ -x "${HOMEBREW_PREFIX}/bin/lua" ] && ln -s "${HOMEBREW_PREFIX}/bin/lua" "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/lua"
    else
      printf "\n"
    fi
  fi

  if [ -x "$(which nvim)" ]; then
    # wait until finishing lazy and mason installations
    # nvim --headless "+Lazy! install" +30sleep +qa
    # Any command can have a bang to make the command wait till it finished.
    # sleep 30-60 seconds until mason finishes installation, lazy and mason works simultaneously.
    printf "run nvim --headless +Lazy! sync +q\n"
    nvim --headless "+Lazy! sync" +30sleep +qa
  fi

}

uninstallNeovimPlugins() {
  printf "remove nvim plugins...\n"
  if [ -d "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/" ]; then
    unlink "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/lua"
    unlink "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks"
  fi

  [ -d "${HOME}/.local/share/nvim" ] && rm -rf "${HOME}/.local/share/nvim"
  [ -d "${HOME}/.local/state/nvim" ] && rm -rf "${HOME}/.local/state/nvim"
  # [ -d "${HOME}/.config/nvim" ] && rm -rf "${HOME}/.config/nvim"
  [ -h "${HOME}/.config/nvim" ] && unlink "${HOME}/.config/nvim"
  # [ -d "${HOME}/repo/LeoVim" ] && rm -rf "${HOME}/repo/LeoVim"
}

installCustomNodejs() {
  printf "install nodejs LTS via nvm \n"
  # # install nodejs LTS via nvm
  export NVM_DIR="${HOME}/.nvm"
  [ -d "$NVM_DIR" ] && (
    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
    cd "$NVM_DIR"
    # git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
  ) && . "$NVM_DIR/nvm.sh" && cd - || return

  # require make, g++, python,
  nvm install --lts
  nvm use --lts
}

uninstallCustomNodejs() {
  nvm uninstall --lst
}

installCustomRust() {
  # install into ${HOME}/.cargo, for linuxbrew doesn't support rust
  # curl https://sh.rustup.rs -sSf | sh -s -- -y -q --no-modify-path
  # curl https://sh.rustup.rs -sSf -y | sh -s -- -y
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  . "${HOME}/.cargo/env"
}

installCustomPython() {
  # [ -n "$1" ] && PYTHON_LATEST_VERSION="$1" || PYTHON_LATEST_VERSION="3.12.8"

  PYTHON_LATEST_VERSION="3.12.8"
  # install python3 with --enable-shared
  # 1. Install Dependencies:
  # apk add build-base glibc-dev zlib-dev libffi-dev ncurses-dev openssl-dev
  # 2. Download and Build Python:
  # wget https://www.python.org/ftp/python/3.12.8/Python-3.12.8.tgz
  # tar xvf Python-3.12.8.tgz
  # cd Python-3.12.8
  # ./configure --enable-shared --prefix=/usr/local
  # make
  # make install
  # 3. Fix Library Linking, add the Python shared library path to ldconfig:
  # echo "/usr/local/lib" >> /etc/ld.so.conf
  # ldconfig
  # 4. Verify Python Installation: Ensure the libpython3.so file exists.
  # ls /usr/local/lib/libpython3.*
  # --------------------------------------------
  # [2-4]OR Install Python via pyenv with --enable-shared:
  # using pyenv to install python3 instead of Alpine built-in python3,
  # for enable to pip3 install pynvim (the python provider of nvim)
  #
  # Python’s build system is often designed around glibc, the GNU C library.
  # Alpine Linux uses musl as its default C library, and while Python can be
  # built on Alpine Linux, certain features (like the _socket module) may break
  # if the build environment is not correctly configured.
  if [ ! -e "$HOME/.pyenv/bin/pyenv" ]; then
    curl https://pyenv.run | bash
    export PYENV_ROOT="$HOME/.pyenv"
    [ -d "$PYENV_ROOT/bin" ] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    # pyenv latest -k 3 | xargs pyenv install
    # PYTHON_LATEST_VERSION=$(pyenv latest -k 3)
    # install cmake-language-server via mason.nvim only python3.12 supported
    # CFLAGS="-I/usr/include" LDFLAGS="-L/usr/lib"
    PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install "$PYTHON_LATEST_VERSION"
    # PYTHON_CONFIGURE_OPTS="--enable-shared --enable-optimizations" pyenv install -v "$PYTHON_LATEST_VERSION"

    pyenv global "$PYTHON_LATEST_VERSION"

    # Ensure that Python is compiled with shared libraries and linked
    # correctly (	openssl-dev, libffi-dev, zlib-dev and xz-dev ).
    # ldd (List Dynamic Dependencies) is a *nix utility that prints the shared libraries
    # required by each program or shared library specified on the command line.
    # ldd "$(pyenv which python3)"

    # Verify OpenSSL After Installation (openssl-dev)
    # Check the _ssl module build status in the Python installation directory
    # ls ~/.pyenv/versions/3.12.8/lib/python3.12/lib-dynload/_ssl*
    printf "verify openssl version: \n"
    python3 -c "import ssl; print(ssl.OPENSSL_VERSION)"

    # Verify _socket module (dependencies: glibc-dev)
    printf "verify socket: \n"
    python3 -c "import socket; print(socket.gethostname())"

    # If pip is missing, install it
    # python3 -m ensurepip --upgrade
    # python3 -m pip install --upgrade pip
  fi

  # Issue: Python built on Alpine Linux (with musl instead of glibc) is
  # incompatible with certain compiled libraries used by
  # YouCompleteMe. Specifically, the missing symbol (PyType_GetModuleByDef)
  # indicates a mismatch between the version of Python used and the libraries
  # that YouCompleteMe depends on.

  # 1. Ensure the required dependencies for building Python
  # 2. Set Environment Variables for pyenv and install Python
  # export PYTHON_CONFIGURE_OPTS="--enable-shared"
  # pyenv install 3.12.8
  # # or specify --enable-shared only for one installation
  # PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.12.8
  # 3. Verify Installation
  # ls "$(pyenv root)/versions/3.12.8/lib/"
  # python3 -m sysconfig | grep enable-shared
  # 4. Update Library Path: add the library path and refresh the linker cache
  # echo "$(pyenv root)/versions/3.12.8/lib" >> /etc/ld.so.conf.d/pyenv.conf
  # ldconfig
  # OR USE shared libraries by specifying library path in user environment.
  # export LD_LIBRARY_PATH="$(pyenv root)/versions/3.12.8/lib:$LD_LIBRARY_PATH"
  # To confirm the dynamic linker is using the correct library path
  # ldd "$(pyenv root)/versions/3.12.8/bin/python3"
  # 3. Rebuild YouCompleteMe
  # Once the LD_LIBRARY_PATH is correctly set, rebuild YouCompleteMe to ensure
  # it can find the shared library,
  # cd ~/.vim/plugged/YouCompleteMe
  # python3 install.py --all

  # --------------------------------------------
}

uninstallCustomPython() {
  PYTHON_LATEST_VERSION="3.12.8"
  pyenv uninstall "$PYTHON_LATEST_VERSION"
  rm -rf "${HOME}/.pyenv"

}

setupTmux() {
  cp ../dotfiles/sh/.tmux.conf "${HOME}/.tmux.conf"

  # Installs and loads tmux plugins.
  # https://github.com/tmux-plugins/tpm

  if [ ! -d "${HOME}"/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm "${HOME}"/.tmux/plugins/tpm
  else
    cd "${HOME}"/.tmux/plugins/tpm && git pull
    cd - || return
  fi

  [ -d "${HOME}/.config/tmuxinator" ] || mkdir -p "${HOME}/.config/tmuxinator"
  cp ../dotfiles/tmux/dev.yml "${HOME}/.config/tmuxinator/dev.yml"

}

cleanTmux() {
  [ -d "${HOME}/.config/tmuxinator" ] && rm -rf "${HOME}/.config/tmuxinator"
  [ -d "${HOME}/.tmux" ] && rm -rf "${HOME}/.tmux"
  [ -f "${HOME}/.tmux.conf" ] && rm -f "${HOME}/.tmux.conf"
  rm -f "${HOME}/tmux*.log"
}

cleanCache() {
  [ -d "${HOME}/.npm" ] && rm -rf "${HOME}/.npm"
  [ -d "${HOME}/.cache" ] && rm -rf "${HOME}/.cache"
  [ -d "${HOME}/.local" ] && rm -rf "${HOME}/.local"
  [ -d "${HOME}/.cargo" ] && rm -rf "${HOME}/.cargo"
}

configGitClient() {
  # config git global settings.
  # git config --global core.editor vi
  # using system $VISUAL variable is better, which maybe nvim or nvr dynamically
  [ -n "$1" ] && user=$1 || user="Jiang Zhu"
  [ -n "$2" ] && email=$2 || email="m.zhujiang@gmail.com"

  printf "Configuring git for %s ...\n" "$user"

  git config --global user.name "$user"
  git config --global user.email "$email"

  git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
  git config --global color.ui true
  git config --global color.ui true
  git config --global color.diff-highlight.oldNormal "red bold"
  git config --global color.diff-highlight.oldHighlight "red bold 52"
  git config --global color.diff-highlight.newNormal "green bold"
  git config --global color.diff-highlight.newHighlight "green bold 22"
  git config --global color.diff.meta "11"
  git config --global color.diff.frag "magenta bold"
  git config --global color.diff.commit "yellow bold"
  git config --global color.diff.old "red bold"
  git config --global color.diff.new "green bold"
  git config --global color.diff.whitespace "red reverse"
  git config --global diff-so-fancy.stripLeadingSymbols false
  git config --global diff-so-fancy.useUnicodeRuler false

  git config --global alias.st status
  git config --global alias.co checkout
  git config --global alias.ad add
  git config --global alias.ap 'add --patch'
  git config --global alias.ai 'add --interactive'
  git config --global alias.ci commit
  git config --global alias.br branch
  git config --global alias.ignore \
    '!gi() { curl -sL https://www.gitignore.io/api/$@ ;}; gi'
  git config --global alias.last 'log -1 HEAD'
  git config --global alias.unstage 'reset HEAD --'
  git config --global alias.sdiff '!'"git diff && git submodule foreach 'git diff'"
  git config --global alias.spush 'push --recurse-submodules=on-demand'
  git config --global alias.supdate 'submodule update --remote --merge'

  git config --global init.defaultBranch main

  git config --global merge.conflictstyle diff3
  git config --global merge.tool vimdiff
  git config --global merge.conflictstyle diff3
  git config --global mergetool.prompt false
  git config --global mergetool.keepBackup false

  git config --global diff.tool vimdiff
  git config --global diff.submodule log
  git config --global difftool.prompt false

  git config --global rerere.enabled true
  git config --global credential.helper cache

  git config --global pull.rebase true
}

# git and github -----------------------------------------------------------
setupSSH() {
  [ -n "$1" ] && email=$1 || email="m.zhujiang@gmail.com"

  ID_RSA_FILE=${HOME}/.ssh/id_ed25519
  if [ -f "${ID_RSA_FILE}" ]; then
    printf "%s found.\n" "${ID_RSA_FILE}"
  else
    printf "generate ssh key to access github with git ssh protocol.\n"
    # cd "${HOME}" || return 1

    # ssh-keygen -t rsa -b 4096 -C "m.zhujiang@gmail.com" -f "${HOME} /.ssh/id_rsa" -N ""
    # https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
    ssh-keygen -t ed25519 -C "$email" -f "${HOME}/.ssh/id_ed25519" -N ""
    eval "$(ssh-agent -s)"
    ssh-add "${HOME}/.ssh/id_ed25519"
    # cd - || return
  fi

  printf "add public ssh_key in %s to the projects in github munually please,\n" "${HOME}/.ssh/id_ed25519.pub"
  printf "otherwise just skip it and continue ...\n"

  # and add ssh_key to github
  printf "ref: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#platform-linux\n"
  printf "for mac user: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#platform-mac\n"

  printf "\nImportant!!!\n"
  printf "Ensure adding ssh public key to github's projects which you host ...\n"
}

cleanSSH() {
  [ -f "${HOME}/.ssh/id_ed25519" ] && rm -f "${HOME}/.ssh/id_ed25519*"
}

configShell() {
  for CFG_FILE in .inputrc .editorconfig .czrc .golangci.yml; do
    # ln -s "${dotfiles_dir}/sh/${CFG_FILE}" "${HOME}/${CFG_FILE}"
    cp ../dotfiles/sh/${CFG_FILE} "${HOME}/${CFG_FILE}"
  done

  for CFG_FILE in .bash_profile .bashrc .bash_logout; do
    cp ../dotfiles/sh/${CFG_FILE} "${HOME}/${CFG_FILE}"
  done

  for CFG_FILE in .zshenv .zprofile .zshrc .zlogin .zlogout; do
    cp ../dotfiles/sh/${CFG_FILE} "${HOME}/${CFG_FILE}"
  done

  # don't override local config files if already exist
  for CFG_FILE in .bashrc .zshrc; do
    if [ ! -f "${HOME}/${CFG_FILE}.local" ]; then
      cp ../dotfiles/sh/${CFG_FILE}.local "${HOME}/${CFG_FILE}.local"
    fi
  done

  if [ "${SYSOS}" = "Darwin" ]; then
    printf "Addiontal config for Dawrin ...\n"
    printf "iTerm2 users need to set both the Regular font and the Non-ASCII Font in 'iTerm > Preferences > Profiles > Text' to use a patched font.\n"
  fi
}

backupDotFiles() {
  CURRENTDATE=$(date +"%Y-%m-%d-%H%M")
  backupDir="${HOME}/.backup/${CURRENTDATE}"
  mkdir -p "${backupDir}"

  for CFG_FILE in .bash_profile .bashrc .bash_logout; do
    [ -e "${HOME}/${CFG_FILE}" ] && cp "${HOME}/${CFG_FILE}" "${backupDir}/${CFG_FILE}"
  done

  for CFG_FILE in .zlogin .zlogout .zprofile .zshenv .zshrc; do
    [ -e "${HOME}/${CFG_FILE}" ] && cp "${HOME}/${CFG_FILE}" "${backupDir}/${CFG_FILE}"
  done

  for CFG_FILE in .czrc .editorconfig .golangci.yml .gitconfig .inputr .zplug; do
    [ -e "${HOME}/${CFG_FILE}" ] && cp "${HOME}/${CFG_FILE}" "${backupDir}/${CFG_FILE}"
  done

  [ -d "${HOME}/.ssh" ] && cp -r "${HOME}/.ssh" "${backupDir}/.ssh"
  [ -d "${HOME}/.vim" ] && cp -r "${HOME}/.vim" "${backupDir}/.vim"

  mkdir -p "${backupDir}/.config"
  for CFG_DIR in nvim lvim tmuxinator; do
    [ -d "${HOME}/.config/${CFG_DIR}" ] && cp -r "${HOME}/.config/${CFG_DIR}" "${backupDir}/.config/${CFG_DIR}"
  done
  printf "backup config done.\n"
}

removeDotfiles() {
  printf "remove dot files.\n"
  for CFG_FILE in .bash_profile .bashrc .bash_logout; do
    [ -e "${HOME}/${CFG_FILE}" ] && rm "${HOME}/${CFG_FILE}"
  done

  for CFG_FILE in .zlogin .zlogout .zprofile .zshenv .zshrc; do
    [ -e "${HOME}/${CFG_FILE}" ] && rm "${HOME}/${CFG_FILE}"
  done

  for CFG_FILE in .env .czrc .editorconfig .golangci.yml .gitconfig .inputrc .zplug; do
    [ -e "${HOME}/${CFG_FILE}" ] && rm "${HOME}/${CFG_FILE}"
  done

  # TODO: leave .ssh
  [ -d "${HOME}/.ssh" ] && rm -f "${HOME}/.ssh/id_ed25519*"

  # for CFG_FILE in ; do
  #   [ -e "${HOME}/${CFG_FILE}" ] && rm "${HOME}/${CFG_FILE}"
  # done
}

# ------------------------------------------------------------------------------
# helper functions
checkOsDetail() {
  if [ "${SYSOS}" = "Darwin" ]; then
    DISTRO="Darwin"
  elif [ "${SYSOS}" = "Linux" ]; then
    if grep -Eq "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
      DISTRO='CentOS'
    elif grep -Eq "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
      DISTRO='RHEL'
    elif grep -Eq "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
      DISTRO='Fedora'
    elif grep -Eq "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
      DISTRO='Debian'
    elif grep -Eq "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
      DISTRO='Ubuntu'
    elif grep -Eq "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
      DISTRO='Raspbian'
    elif grep -Eq "Arch" /etc/issue || grep -Eq "Arch" /etc/*-release; then
      DISTRO='Arch'
    elif grep -Eq "Alpine" /etc/issue || grep -Eq "Alpine" /etc/*-release; then
      DISTRO='Alpine'
    else
      DISTRO='unknow'
      printf "%s is not supported now.\n" "${SYSOS}"
      false
    fi
  else
    printf "%s is not supported now.\n" "${SYSOS}"
    false
  fi
}

switchShell() {
  [ -n "$1" ] && target_sh="$1" || target_sh="zsh"

  if echo "$SHELL" | grep -q "$target_sh"; then
    return
  fi

  # if current shell is not zsh, promote to change it into zsh.
  printf "\nImportant!!!\n"
  printf "Current \$SHELL is: %s.\n" "${SHELL}"
  eval chsh -s "$(grep "${target_sh}" /etc/shells | tail -n1)" &&
    printf "Please re-login to make %s take effect. \n" "$target_sh" ||
    printf "Fail to switch into %s.\n" "$target_sh"
}

# SetupUserEnv
# CleanUserEnv