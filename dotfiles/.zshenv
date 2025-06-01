# zsh load .zshenv, .zprofile(login shell), .zshrc(interactive shell) and .zlogin(login shell) sequentially
# echo "loading .zshenv"
test -e "${HOME}/.env" && . "${HOME}/.env"
