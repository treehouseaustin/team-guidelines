#!/bin/bash
# .bash_profile
# User specific environment and startup programs
alias ll='/bin/ls -lAFh'
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
# completion scripts
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  . /usr/local/etc/bash_completion.d/git-completion.bash
fi
if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
  . /usr/local/etc/bash_completion.d/git-prompt.sh
fi
if [ -f /usr/local/etc/bash_completion.d/brew-completion.sh ]; then
 . /usr/local/etc/bash_completion.d/brew-completion.sh
fi
# Shell colors
BLACK="\[\e[0;30m\]"  BOLD_BLACK="\[\e[1;30m\]"  UNDER_BLACK="\[\e[4;30m\]"
RED="\[\e[0;31m\]"    BOLD_RED="\[\e[1;31m\]"    UNDER_RED="\[\e[4;31m\]"
GREEN="\[\e[0;32m\]"  BOLD_GREEN="\[\e[1;32m\]"  UNDER_GREEN="\[\e[4;32m\]"
YELLOW="\[\e[0;33m\]" BOLD_YELLOW="\[\e[1;33m\]" UNDER_YELLOW="\[\e[4;33m\]"
BLUE="\[\e[0;34m\]"   BOLD_BLUE="\[\e[1;34m\]"   UNDER_BLUE="\[\e[4;34m\]"
PURPLE="\[\e[0;35m\]" BOLD_PURPLE="\[\e[1;35m\]" UNDER_PURPLE="\[\e[4;35m\]"
CYAN="\[\e[0;36m\]"   BOLD_CYAN="\[\e[1;36m\]"   UNDER_CYAN="\[\e[4;36m\]"
WHITE="\[\e[0;37m\]"  BOLD_WHITE="\[\e[1;37m\]"  UNDER_WHITE="\[\e[4;37m\]"
NO_COLOR="\[\e[0m\]"
function git_status {
  status="$(git status 2> /dev/null | cat)"
  pattern="Changes"
  [[ "$status" =~ "$pattern" ]] && echo "!"
  pattern="untracked files"
  [[ "$status" =~ "$pattern" ]] && echo "*"
}
if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
  export PS1="${CYAN}\h${WHITE}[${YELLOW}\w${WHITE}]\$(__git_ps1 '${WHITE}[${GREEN}%s${RED}'\$(git_status)'${WHITE}]')${WHITE}${NO_COLOR}"
fi
export PS2=" > "
export PS4=" + "
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export GREP_OPTIONS='--color=auto'
export NODE_PATH="'$(npm root -g)'"
