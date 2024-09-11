#!/bin/sh
set -u

printf "uninstall 3d-party packages for python...... \n"
pip3 uninstall -y imgcat
pip3 uninstall -y pynvim
pip3 uninstall -y codespell
pip3 uninstall -y nose
pip3 uninstall -y ruff
pip3 uninstall -y mock
pip3 uninstall -y pep8
pip3 uninstall -y jedi
# pip3 uninstall -y powerline-status

#
# uninstall gem 3d party packages

printf "uninstall 3d-party packages for ruby...... \n"
# gem uninstall html2haml
# gem uninstall sass
# sudo gem uninstall html2haml
# sudo gem uninstall sass

# uninstall node.js 3d party packages
printf "uninstall nodejs 3d-party packages...... \n"
npm uninstall -g typescript
npm uninstall -g create-react-app
npm uninstall -g npx
npm uninstall -g serve
npm uninstall -g react-devtools
npm uninstall -g eslint
npm uninstall -g prettier
npm uninstall -g js-beautify
npm uninstall -g js2coffee
npm uninstall -g commander
npm uninstall -g async npm uninstall -g rimraf
npm uninstall -g winston
npm uninstall -g colors
npm uninstall -g simplehttpserver
npm uninstall -g mongo-hacker
npm uninstall -g npx
npm uninstall -g grunt-cli
npm uninstall -g neovim
npm uninstall -g gatsby-cli
npm uninstall -g surge

# 1. uninstall all libs, packages and tools
printf "Start uninstalling libs, packages and tools......\n"

brew uninstall neovim vim nginx
brew uninstall fzf
brew uninstall reattach-to-user-namespace astyle readline xz pcre openssl gd
brew uninstall pipenv python3 go ruby rust jq yarn npm node
brew uninstall cmake wget git xclip zsh tmux httpie