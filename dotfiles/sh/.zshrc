# if the shell is interactive, commands are read from /etc/zshrc and then $ZDOTDIR/.zshrc
# usually set personal preferences for the command line for interactive shell: custom prompt, specific color scheme...

# echo "loading .zshrc"
# zmodload zsh/zprof
# PS4=$'\\\011%D{%s%6.}\011%x\011%I\011%N\011%e\011'
# exec 3>&2 2>/tmp/zshstart.$$.log
# setopt xtrace prompt_subst

# debug
# cur_sec_and_ns=`gdate '+%s-%N'`
# cur_sec=${cur_sec_and_ns%-*}
# cur_ns=${cur_sec_and_ns##*-}
# cur_timestamp=$((cur_sec*1000+cur_ns/1000000))
# start=$cur_timestamp
# echo 1 $cur_timestamp

test -e ${HOME}/.x_shrc && . ${HOME}/.x_shrc

# [oh-my-zsh] Insecure completion-dependent directories detected:
# [oh-my-zsh] If the above didn't help or you want to skip the verification of
# [oh-my-zsh] insecure directories you can set the variable ZSH_DISABLE_COMPFIX to
# [oh-my-zsh] "true" before oh-my-zsh is sourced in your zshrc file.
ZSH_DISABLE_COMPFIX=true

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="amuse"
# ZSH_THEME="avit"
# ZSH_THEME="bureau"
# ZSH_THEME="imajes"
ZSH_THEME="kolo"  # simple style
# ZSH_THEME="rgm"
# ZSH_THEME="sammy"

# POWERLINE_ZSH=${PY_PACKS_LOC}/powerline/bindings/zsh/powerline.zsh
# test -e ${POWERLINE_ZSH} && . ${POWERLINE_ZSH}

# Uncomment the following line to use case-eensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-eetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ${HOME}/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ${HOME}/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-completions forgit extract vi-mode docker)
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-completions vi-mode)
# oh-my-zsh takes 131ms, and 235ms with plugins
test -e ${ZSH}/oh-my-zsh.sh && . ${ZSH}/oh-my-zsh.sh

# tmp=$cur_timestamp
# cur_sec_and_ns=`gdate '+%s-%N'`
# cur_sec=${cur_sec_and_ns%-*}
# cur_ns=${cur_sec_and_ns##*-}
# cur_timestamp=$((cur_sec*1000+cur_ns/1000000))
# echo "source oh-my-zsh" $((cur_timestamp - tmp))

# earse env variables $PAGER and $LESS setted by oh-my-zsh, which cause git branch/diff's output paged by less
unset PAGER
unset LESS

# oh-my-zsh has done it. press <C-x><C-e> to start editing in vi.
# autoload -U edit-command-line
# zle -N edit-command-line
# bindkey '^x^e' edit-command-line


# autojump is a faster way to navigate your filesystem.
# It works by maintaining a database of the directories you use the most from the command line.
# Directories must be visited first before they can be jumped to.
test -e ${HOMEBREW_PREFIX}/etc/profile.d/autojump.sh  && source ${HOMEBREW_PREFIX}/etc/profile.d/autojump.sh
# add fzf to zsh
[ -e ${HOME}/.fzf.zsh ] && . ${HOME}/.fzf.zsh

[ -e ${HOME}/.local/scripts/.zshrc.local ] && . ${HOME}/.local/scripts/.zshrc.local
# unsetopt xtrace
# exec 2>&3 3>&-

# zprof

[ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zsh