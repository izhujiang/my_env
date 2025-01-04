#!/bin/sh
# set -eux
set -u
# for debug: print command before execute it
# set -x
# enable to exit when errors occur.
# set -euxo pipefail

helpme() {
  printf "Install system packages and user environment.n"
  printf "./my_env.sh [all]\n"
  printf "Install system packages only.\n"
  printf "./my_env.sh sys\n"
  printf "Install prerequisites only.\n"
  printf "./my_env.sh prerequisites\n"
  printf "Setup user environment only.\n"
  printf "./my_env.sh user\n"
  printf "Clean user environment.\n"
  printf "./my_env.sh clean\n"
  printf "Uninstall system packages.\n"
  printf "./my_env.sh cleansys\n"
  printf "Clean user environment and uninstall system packages.\n"
  printf "./my_env.sh cleanall\n"
  printf "Hlep\n"
  printf "./my_env.sh [help|-h]\n"
}

# entry of main script
printf "Running on %s ...\n" $(uname -s)

if [ $# -eq 0 ] || [ "$1" = "all" ]; then
  printf "Install system packages and user environment...\n"
  . ./sys_packages.sh
  InstallSystemPackages
  . ./user_packages.sh
  SetupUserEnv
else
  case $1 in
  "prerequisites")
    printf "Install prerequisites packages ...\n"
    . ./sys_packages.sh
    InstallPrerequisites
    ;;
  "sys")
    printf "Install system packages only...\n"
    . ./sys_packages.sh
    InstallSystemPackages
    ;;
  "user")
    printf "Setup user environment only...\n"
    . ./user_packages.sh
    SetupUserEnv
    ;;
  "clean")
    printf "Clean user environment ...\n"
    . ./user_packages.sh
    CleanUserEnv
    ;;
  "cleansys")
    printf "Uninstall system packages...\n"
    . ./sys_packages.sh
    UninstallSystemPackages
    ;;
  "cleanall")
    printf "Clean user environment and uninstall system packages...\n"
    . ./user_packages.sh
    CleanUserEnv
    . ./sys_packages.sh
    UninstallSystemPackages
    ;;
  "help" | "-help" | "--help" | "-h")
    helpme
    ;;
  *)
    printf "Unknown command: %s\n" "$1"
    help
    ;;
  esac
fi