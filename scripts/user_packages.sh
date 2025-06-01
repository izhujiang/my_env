#!/bin/sh
set -u

SYSOS=$(uname -s)
DISTRO=""

# main entry -----------------------------------------------------------------
SetupUserEnv() {
  checkOsDetail || return

  installZshPlugins
  installFonts

  # install rust and rust-tools (rustup, rustc, cargo, rust-analyzer and others)
  # curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q --no-modify-path

  if [ "${SYSOS}" = "Darwin" ]; then
    installRustPackages
    installGolangPackages
    installNodejsPackages
    installPythonPackages

    # Pre-installed macOS system Vim does not support Python 3.
    installCustomVim
    installVimPlugins

    installNeovimPlugins
    # install lunarvim
    # curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh | bash /dev/stdin --install-dependencies
    installVscodePlugins

    installCustomOthers
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

      installRustPackages
      installGolangPackages
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
      installCustomOthers
      ;;
    "Alpine")
      installRustPackages
      installGolangPackages
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
  setupDotfiles
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
    uninstallCustomOthers

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
      uninstallCustomOthers
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
  # python3 -m ensurepip --upgrade
  # python3 -m pip install --upgrade pip
  printf "Install 3d-party packages for python...... \n"
  printf "Current pip3: %s\n" "$(which pip3)"
  # pip3 install -U "$python_3rd_packages"
  # pip3 install -U build # or
  # pip3 install -U setuptools
  # pip3 install -U imgcat

  # Install globally.
  uv tool install ruff@latest
  uv tool install debugpy@latest
  uv tool install cmake-language-server@latest
}
uninstallPythonPackages() {
  # install python 3rd party packages
  printf "uninstall 3d-party packages for python...... \n"
  # rev_python_3rd_packages=$(echo "$python_3rd_packages" | tr ' ' '\n' | sed '1!G;h;$!d' | tr '\n' ' ')
  # eval pip3 uninstall "$rev_python_3rd_packages"
  # pip3 uninstall imgcat
  uv tool uninstall cmake-language-server
  uv tool uninstall debugpy
  uv tool uninstall ruff
  # uv tool uninstall pynvim
  # pip3 uninstall setuptools
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

  # printf "change npm global repository where node_modules stored ...\n"
  # npm config set prefix "${HOME}/.local"
  # [ -d "${HOME}/.local/lib" ] || mkdir -p "${HOME}/.local/lib"

  # npm install -g npm

  npm install -g typescript
  npm install -g typescript-language-server
  npm install -g bash-language-server
  npm install -g pyright # python lsp
  npm install -g @biomejs/biome
  npm install -g @commitlint/{cli,config-conventional}
  npm install -g markdownlint-cli2

  npm install -g neovim
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
  npm uninstall -g neovim

  npm uninstall -g markdownlint-cli2
  npm uninstall -g @commitlint/{cli,config-conventional}
  npm uninstall -g @biomejs/biome
  npm uninstall -g pyright
  npm uninstall -g bash-language-server
  npm uninstall -g typescript-language-server
  npm uninstall -g typescript

  # npm uninstall -g commitizen conventional-changelog cz-conventional-changelog
  # npm uninstall -g lighthouse
  # npm uninstall -g eslint js-beautify
  # npm uninstall -g serve

  # TODO: rm .npm
  # rm -rf "${HOME}/.npm"
  rm -f "${HOME}/.npmrc"
}
#
# -----------------------------------------------------------------------------
installRustPackages() {
  printf "Install 3d-party packages for rust ...\n"
  cargo install tlrc
  cargo install tree-sitter-cli
  cargo install selene
  cargo install stylua
  cargo install deno

  # uv is available via Cargo, but must be built from Git rather than crates.io due to its dependency on unpublished crates.
  cargo install --git https://github.com/astral-sh/uv uv

  # cargo install mocword
  # printf("please download mocword-data manually from https://github.com/high-moctane/mocword-data/releases/tag/eng20200217")
  # mkdir -p ~/.local/share/mocword/
  # printf("and setup: export MOCWORD_DATA=/path/to/mocword.sqlite")
  # curl --verbose --output-dir ~/.local/share/mocword/ --remote-name https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
}
uninstallRustPackages() {
  printf "Uninstall 3d-party packages for rust ...\n"

  # cargo uninstall mocword

  # Mason don't support selene on alpine
  cargo uninstall uv
  cargo uninstall deno
  cargo uninstall stylua
  cargo uninstall selene
  cargo uninstall tree-sitter-cli
  cargo uninstall tlrc

  rm -rf "${HOME}/.cargo"
}

# -----------------------------------------------------------------------------
installGolangPackages() {
  # fix issure: cannot use path@version syntax in GOPATH mode
  export GO111MODULE=on
  # golang
  export GOPATH=${HOME}/workspace/go
  export PATH=${GOPATH}/bin:${PATH}

  printf "Install tools and binaries to GOPATH: %s for golang ...\n" "${GOPATH}"
  # developer tooling dependencies, use to assist with development, testing, build, or deployment
  #   - staticcheck for static code analysis
  #   - govulncheck for vulnerability scanning
  #   - air for live-reloading applications
  #   - ...
  #   see: go tool management (manage developer tools: https://www.alexedwards.net/blog/how-to-manage-tool-dependencies-in-go-1.24-plus)

  # ref: https://pkg.go.dev/golang.org/x
  # Go ships with a number of builtin tools, and additional tools may be defined in the go.mod of the current module
  go install golang.org/x/tools/...@latest
  # golang.org/x/tools/gopls module, whose root package is a language-server protocol (LSP) server for Go.
  go install golang.org/x/tools/gopls/...@latest
  go install golang.org/x/pkgsite/...@latest
  # vulnerability management includes tooling for analyzing your codebase and binaries to surface known vulnerabilities in your dependencies.
  go install golang.org/x/vuln/...@latest

  # for none-ls
  go install github.com/davidrjenni/reftools/...@latest
  go install github.com/fatih/gomodifytags@latest
  go install github.com/josharian/impl@latest

  go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
  go install github.com/go-delve/delve/cmd/dlv@latest   # dlv for debugging
  go install github.com/air-verse/air@latest            # Live reload for Go apps
  go install github.com/goreleaser/goreleaser/v2@latest # a release automation tool, supports Go, Rust, Zig, and TypeScript

  go install github.com/junegunn/fzf@latest
  go install github.com/jesseduffield/lazygit@latest

  go install mvdan.cc/sh/v3/cmd/shfmt@latest                  # shell formater
  go install github.com/mrtazz/checkmake/cmd/checkmake@latest # experimental linter/analyzer for Makefiles
  go install github.com/client9/misspell/cmd/misspell@latest  # correct commonly misspelled English words in source files
}

uninstallGolangPackages() {
  printf "Uninstall tools and packages: %s...\n" "${GOPATH}"
  # rm ${GOPATH}/bin/${file}

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
    [ -e "${HOME}/.vim/${CFG_FILE}" ] || cp ../dotfiles/vim/${CFG_FILE} "${HOME}/.vim/${CFG_FILE}"
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
  [ -d "${HOME}/.config/nvim" ] || ln -s "${HOME}/repo/LeoVim" "${HOME}/.config/nvim"

  [ -d "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/" ] || (
    mkdir -p "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/"

    if [ "${SYSOS}" = "Linux" ]; then
      [ -x /usr/bin/luarocks-5.1 ] && ln -s /usr/bin/luarocks-5.1 "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks"
      [ -x /usr/bin/lua ] && ln -s /usr/bin/lua "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/lua"
    elif [ "${SYSOS}" = "Darwin" ]; then
      [ -x "${HOMEBREW_PREFIX}/bin/luarocks" ] && ln -s "${HOMEBREW_PREFIX}/bin/luarocks" "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks"
      [ -x "${HOMEBREW_PREFIX}/bin/lua" ] && ln -s "${HOMEBREW_PREFIX}/bin/lua" "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/lua"
    else
      printf "\n"
    fi
  )

  [ -x "$(which nvim)" ] && (
    # wait until finishing lazy and mason installations
    # nvim --headless "+Lazy! install" +30sleep +qa
    # Any command can have a bang to make the command wait till it finished.
    # sleep 30-60 seconds until mason finishes installation, lazy and mason works simultaneously.
    printf "run nvim --headless +Lazy! sync +q\n"
    nvim --headless "+Lazy! sync" +30sleep +qa
  )

}

uninstallNeovimPlugins() {
  printf "remove nvim plugins...\n"
  [ -d "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/" ] && (
    unlink "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/lua"
    unlink "${HOME}/.local/share/nvim/lazy-rocks/hererocks/bin/luarocks"
  )

  [ -d "${HOME}/.local/share/nvim" ] && rm -rf "${HOME}/.local/share/nvim"
  [ -d "${HOME}/.local/state/nvim" ] && rm -rf "${HOME}/.local/state/nvim"
  # [ -d "${HOME}/.config/nvim" ] && rm -rf "${HOME}/.config/nvim"
  [ -h "${HOME}/.config/nvim" ] && unlink "${HOME}/.config/nvim"
  # [ -d "${HOME}/repo/LeoVim" ] && rm -rf "${HOME}/repo/LeoVim"
}

# install nodejs LTS via nvm
installCustomNodejs() {
  printf "install nodejs LTS via nvm \n"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

  # export NVM_DIR="${HOME}/.nvm"
  # [ -d "$NVM_DIR" ] && (
  #   git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  #   cd "$NVM_DIR"
  #   # git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
  # ) && . "$NVM_DIR/nvm.sh" && cd - || return

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
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y -q --no-modify-path
  . "${HOME}/.cargo/env"
}

# installCustomPython() {
#   # [ -n "$1" ] && PYTHON_LATEST_VERSION="$1" || PYTHON_LATEST_VERSION="3.12.8"
#
#   PYTHON_LATEST_VERSION="3.12.8"
#   # install python3 with --enable-shared
#   # 1. Install Dependencies:
#   # apk add build-base glibc-dev zlib-dev libffi-dev ncurses-dev openssl-dev
#   # 2. Download and Build Python:
#   # wget https://www.python.org/ftp/python/3.12.8/Python-3.12.8.tgz
#   # tar xvf Python-3.12.8.tgz
#   # cd Python-3.12.8
#   # ./configure --enable-shared --prefix=/usr/local
#   # make
#   # make install
#   # 3. Fix Library Linking, add the Python shared library path to ldconfig:
#   # echo "/usr/local/lib" >> /etc/ld.so.conf
#   # ldconfig
#   # 4. Verify Python Installation: Ensure the libpython3.so file exists.
#   # ls /usr/local/lib/libpython3.*
#   # --------------------------------------------
#   # [2-4]OR Install Python via pyenv with --enable-shared:
#   # using pyenv to install python3 instead of Alpine built-in python3,
#   # for enable to pip3 install pynvim (the python provider of nvim)
#   #
#   # Python’s build system is often designed around glibc, the GNU C library.
#   # Alpine Linux uses musl as its default C library, and while Python can be
#   # built on Alpine Linux, certain features (like the _socket module) may break
#   # if the build environment is not correctly configured.
#
#   if [ ! -d "$HOME/.pyenv" ]; then
#     [ -z "$(command -v pyenv)" ] && curl -fsSL https://pyenv.run | bash
#     export PYENV_ROOT="$HOME/.pyenv"
#     [ -d "$PYENV_ROOT/bin" ] && export PATH="$PYENV_ROOT/bin:$PATH"
#     eval "$(pyenv init -)"
#     # pyenv latest -k 3 | xargs pyenv install
#     # PYTHON_LATEST_VERSION=$(pyenv latest -k 3)
#     # install cmake-language-server via mason.nvim python(<=3.12) supported
#     # CFLAGS="-I/usr/include" LDFLAGS="-L/usr/lib"
#     PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install "$PYTHON_LATEST_VERSION"
#     # PYTHON_CONFIGURE_OPTS="--enable-shared --enable-optimizations" pyenv install -v "$PYTHON_LATEST_VERSION"
#
#     pyenv global "$PYTHON_LATEST_VERSION"
#
#     # Ensure that Python is compiled with shared libraries and linked
#     # correctly (	openssl-dev, libffi-dev, zlib-dev and xz-dev ).
#     # ldd (List Dynamic Dependencies) is a *nix utility that prints the shared libraries
#     # required by each program or shared library specified on the command line.
#     # ldd "$(pyenv which python3)"
#
#     # Verify OpenSSL After Installation (openssl-dev)
#     # Check the _ssl module build status in the Python installation directory
#     # ls ~/.pyenv/versions/3.12.8/lib/python3.12/lib-dynload/_ssl*
#     printf "verify openssl version: \n"
#     python3 -c "import ssl; print(ssl.OPENSSL_VERSION)"
#
#     # Verify _socket module (dependencies: glibc-dev)
#     printf "verify socket: \n"
#     python3 -c "import socket; print(socket.gethostname())"
#
#     # If pip is missing, install it
#     # python3 -m ensurepip --upgrade
#     # python3 -m pip install --upgrade pip
#   fi
#
#   # Issue: Python built on Alpine Linux (with musl instead of glibc) is
#   # incompatible with certain compiled libraries used by
#   # YouCompleteMe. Specifically, the missing symbol (PyType_GetModuleByDef)
#   # indicates a mismatch between the version of Python used and the libraries
#   # that YouCompleteMe depends on.
#
#   # 1. Ensure the required dependencies for building Python
#   # 2. Set Environment Variables for pyenv and install Python
#   # export PYTHON_CONFIGURE_OPTS="--enable-shared"
#   # pyenv install 3.12.8
#   # # or specify --enable-shared only for one installation
#   # PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install 3.12.8
#   # 3. Verify Installation
#   # ls "$(pyenv root)/versions/3.12.8/lib/"
#   # python3 -m sysconfig | grep enable-shared
#   # 4. Update Library Path: add the library path and refresh the linker cache
#   # echo "$(pyenv root)/versions/3.12.8/lib" >> /etc/ld.so.conf.d/pyenv.conf
#   # ldconfig
#   # OR USE shared libraries by specifying library path in user environment.
#   # export LD_LIBRARY_PATH="$(pyenv root)/versions/3.12.8/lib:$LD_LIBRARY_PATH"
#   # To confirm the dynamic linker is using the correct library path
#   # ldd "$(pyenv root)/versions/3.12.8/bin/python3"
#   # 3. Rebuild YouCompleteMe
#   # Once the LD_LIBRARY_PATH is correctly set, rebuild YouCompleteMe to ensure
#   # it can find the shared library,
#   # cd ~/.vim/plugged/YouCompleteMe
#   # python3 install.py --all
#
#   # --------------------------------------------
# }

# uninstallCustomPython() {
#   PYTHON_LATEST_VERSION="3.12.8"
#   pyenv uninstall "$PYTHON_LATEST_VERSION"
#   rm -rf "${HOME}/.pyenv"
# }

installCustomOthers() {
  # Make sure you have GitHub CLI (gh) installed.
  gh ext install meiji163/gh-notify
}
uninstallCustomOthers() {
  gh ext remove meiji163/gh-notify
}

setupTmux() {
  [ -e "${HOME}/.tmux.conf" ] || cp ../dotfiles/sh/.tmux.conf "${HOME}/.tmux.conf"

  # Installs and loads tmux plugins.
  # https://github.com/tmux-plugins/tpm

  if [ ! -d "${HOME}"/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm "${HOME}"/.tmux/plugins/tpm
  else
    cd "${HOME}"/.tmux/plugins/tpm && git pull
    cd - || return
  fi

  [ -d "${HOME}/.config/tmuxinator" ] || mkdir -p "${HOME}/.config/tmuxinator"
  [ -e "${HOME}/.config/tmuxinator/dev.yml" ] || cp ../dotfiles/.config/tmuxinator/dev.yml "${HOME}/.config/tmuxinator/dev.yml"
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

  # Both branch.autosetuprebase and pull.rebase control whether git pull uses rebase instead of merge, but they apply in different ways.
  # Setting	                          Scope	                            Applies To
  # branch.autosetuprebase always     Affects new branches only         New branches tracking a remote
  # pull.rebase true                  Affects all branches              All branches when using git pull

  # This setting determines whether new branches automatically inherit the rebase behavior when tracking a remote branch.
  git config --global branch.autosetuprebase always
  # This setting controls the default behavior of git pull for all branches.
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

setupDotfiles() {
  for CFG_FILE in .inputrc .editorconfig .czrc .golangci.yml; do
    [ -e "${HOME}/${CFG_FILE}" ] || cp ../dotfiles/${CFG_FILE} "${HOME}/${CFG_FILE}"
  done

  for CFG_FILE in .bash_profile .bashrc .bash_logout; do
    [ -e "${HOME}/${CFG_FILE}" ] || cp ../dotfiles/${CFG_FILE} "${HOME}/${CFG_FILE}"
  done

  for CFG_FILE in .zshenv .zprofile .zshrc .zlogin .zlogout; do
    [ -e "${HOME}/${CFG_FILE}" ] || cp ../dotfiles/${CFG_FILE} "${HOME}/${CFG_FILE}"
  done

  # don't override local config files if already exist
  for CFG_FILE in .bashrc .zshrc; do
    [ -e "${HOME}/${CFG_FILE}.local" ] || cp ../dotfiles/${CFG_FILE}.local "${HOME}/${CFG_FILE}.local"
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
