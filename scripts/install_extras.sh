#!/bin/sh
set -u

# Install 3d-party packages for Python, Node.js, Ruby, Zsh and vim/nvim.

installPythonPackages() {
  # install python 3rd party packages
  printf "install 3d-party packages for python...... \n"
  printf "current pip3: %s\n" "$(which pip3)"
  pip3 install -U pip
  pip3 install -U pep8 mock ruff pynvim imgcat
}

installRubyPackages() {
  # install gem 3d party packages
  printf "install 3d-party packages for ruby ...\n"
  # gem install html2haml
  # gem install sass
  # sudo gem install html2haml
  # sudo gem install sass
}

installNodejsPackages() {
  # install node.js 3d party packages
  printf "install nodejs 3d-party packages ...\n"
  printf "change npm global repository where node_modules stored ...\n"

  npm config set prefix "${HOME}/.local"
  test -d "${HOME}/.local/lib" || mkdir "${HOME}/.local/lib"

  npm install -g npm
  npm install -g neovim typescript serve eslint js-beautify \
    mongo-hacker lighthouse tree-sitter-cli @microsoft/inshellisense \
    commitizen conventional-changelog cz-conventional-changelog

  # @microsoft/inshellisense # IDE style command line auto complete by microsoft

  #  git commit message guidelines:
  # https://gist.github.com/abravalheri/34aeb7b18d61392251a2
  # https://github.com/commitizen/cz-cli
  # Generate changelogs and release notes. https://github.com/conventional-changelog/conventional-changelog
}

# installRustPackages() {
#   cargo install selene
# }

installGolangPackages() {
  printf "install go tools packages ...\n"
  export GOPATH="$HOME/workspace/go"
  # fix issure: cannot use path@version syntax in GOPATH mode
  export GO111MODULE=on

  printf "install tools to GOPATH(%s) for golang ...\n" "${GOPATH}"

  # gopls, the Go language server
  go install github.com/acroca/go-symbols@latest
  go install github.com/client9/misspell/cmd/misspell@latest
  go install github.com/cweill/gotests@latest
  go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
  go install github.com/fatih/gomodifytags@latest
  go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest # no -u
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
  go install github.com/tpng/gopkgs@latest
  go install github.com/uudashr/gopkgs/cmd/gopkgs@latest
  go install github.com/zmb3/goaddimport@latest
  go install github.com/zmb3/gogetdoc@latest
  go install golang.org/x/blog@latest
  go install golang.org/x/lint/golint@latest
  go install golang.org/x/tools/cmd/godoc@latest
  go install golang.org/x/tools/cmd/goimports@latest
  go install golang.org/x/tools/cmd/gorename@latest
  go install golang.org/x/tools/cmd/stringer@latest
  go install golang.org/x/tools/gopls@latest
  go install sourcegraph.com/sqs/goreturns@latest
}

installVscodePlugins() {
  command -v code >/dev/null 2>&1 || return 1

  printf "install extension for code ...\n"
  code --force --install-extension bmuskalla.vscode-tldr
  code --force --install-extension vscodevim.vim

  SYSOS=$(uname -s)
  if [ "${SYSOS}" = "Darwin" ]; then
    # To enable key-repeating, ref https://github.com/VSCodeVim/Vim
    defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
  fi

  printf "todo: install more extensions for vscode.\n"
}

installExtensivePackages() {
  installPythonPackages
  installRubyPackages
  installNodejsPackages
  # installRustPackages
  installGolangPackages
  installVscodePlugins || return 1
}

installExtensivePackages