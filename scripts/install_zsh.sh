#!/bin/sh
set -u

SYSOS=$(uname -s)

checkZsh() {
  printf "\nchecking zsh ...\n"
  HAS_ZSH=$(grep zsh /etc/shells | head -n1)
  if [ "${HAS_ZSH}" != '' ]; then
    printf "%s \n" "$(zsh --version)"
    # chsh -s $(which zsh)

  else
    printf "No zsh found: install zsh and oh-my-zsh for more productive.\n"
    printf "Otherwise, just skip it and use bash if have no sudo privilege.\n"

    # todo: install zsh if have sudo privilege
    # grep -q "$(which zsh)" /etc/shells || sudo -s "echo $(which zsh) >> /etc/shells" && chsh -s $(which zsh)
    # grep -q "$(which zsh)" /etc/shells || sudo -s "echo $(which zsh) >> /etc/shells"
    return 1
  fi
}

installZshPlugins() {
  # assuming zsh exists in /etc/shells, install ohmyzsh and powerline as well as custom plugins
  printf "install oh-my-zsh and other plugins for zsh ...\n"

  # install zsh plugins
  printf "installing plugins for zsh\n"
  export ZSH="${HOME}/.oh-my-zsh"
  export ZSH_CUSTOM="${ZSH}/custom"

  rm -rf "${ZSH}"
  # sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh) --skip-chsh --unattended --keep-zshrc"

  printf "\nInstall plugins for oh-my-zsh ...\n"
  # manage zsh_plugins with zplug instead.
  for plugin in zsh-autosuggestions zsh-syntax-highlighting zsh-completions; do
    if [ ! -d "${ZSH_CUSTOM}"/plugins/${plugin} ]; then
      # git clone git://github.com/zsh-users/${plugin} "${ZSH_CUSTOM}"/plugins/${plugin}
      git clone https://github.com/zsh-users/${plugin}.git "${ZSH_CUSTOM}"/plugins/${plugin}
    else
      cd "${ZSH_CUSTOM}"/plugins/${plugin} && git pull
    fi
  done
}

configBashZsh() {
  # cd ${HOME}
  printf "\nConfuging sh(bash, zsh) profiles ...\n"
  CURRENTDATE=$(date +"%Y-%m-%d-%H%M")
  for CFG_FILE in .zshenv .x_profile .bash_profile .zprofile .x_shrc .bashrc .zshrc .zlogin .bash_logout .zlogout .inputrc; do
    if [ -f "${HOME}/${CFG_FILE}" ]; then
      mv "${HOME}/${CFG_FILE}" "${HOME}/${CFG_FILE}.${CURRENTDATE}"
    fi
    # curl -fsSL -o "${HOME}/${CFG_FILE}" https://raw.githubusercontent.com/izhujiang/my_env/master/dotfiles/sh/${CFG_FILE}
    cp ../dotfiles/sh/${CFG_FILE} "${HOME}/${CFG_FILE}"
  done
  # don't override local config file
  for CFG_FILE in .shtk; do
    if [ ! -f "${HOME}/.local/scripts/${CFG_FILE}.local" ]; then
      # curl -fsSL --create-dirs -o "${HOME}/.local/scripts/${CFG_FILE}.local" https://raw.githubusercontent.com/izhujiang/my_env/master/dotfiles/sh/${CFG_FILE}.sample
      cp ../dotfiles/sh/${CFG_FILE}.sample "${HOME}/.local/scripts/${CFG_FILE}.local"
    fi
  done

  if [ "${SYSOS}" = "Darwin" ]; then
    printf "Addiontal config for Dawrin ...\n"
    printf "iTerm2 users need to set both the Regular font and the Non-ASCII Font in 'iTerm > Preferences > Profiles > Text' to use a patched font.\n"
    # printf "Ref: https://github.com/powerline/fonts\n"
  fi #ifend
}

installZshEnv() {
  checkZsh
  if [ "${HAS_ZSH}" = '' ]; then
    # installPowerline
    configBashZsh
    printf "\nIt's better to have zsh installed. Ask your administrator for help and 'run install_zsh.sh' again ...\n"
    return 1
  else
    installZshPlugins
    # installPowerline
    configBashZsh

    # if current shell is not zsh, promote to change it into zsh.
    if [ "${SHELL%%zsh}" = "${SHELL}" ]; then
      # todo: add parameter($1 or --allowSwitchZsh) to enable switch into zsh automatically.
      printf "\nCurrent \$SHELL is: %s.\n" "${SHELL}"
      # while true; do
      #     read -ep "Do you wish to run chsh for switching into zsh now? Y/[n]" -i "Y" yn
      # case $yn in
      #     [Yy]* )
      chsh -s "$(grep zsh /etc/shells | head -n1)" || printf "Fail to switch into zsh.\n"
      return 1
      printf "\nImport!!!\n"
      # printf "Logout(use logout command) and start a new login session for \$SHELL change to take effect. \n"
      printf "Please re-login to make zsh take effect. \n"
      printf "Because chsh command have updated /etc/passwd for current user.\n"
      # break;;
      # [Nn]* )
      #     printf "Run \'%s\' to switch into zsh manually.\n" "chsh -s $(grep zsh /etc/shells | head -n1)"
      #     exit;;
      # * )
      #     printf "Please answer yes or no.\n";;
      # esac
      # done
    else
      printf "\n %s configure has changed, please re-login to take effect. \n" "${SHELL}"
    fi
  fi
}

installZshEnv