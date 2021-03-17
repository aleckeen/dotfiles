#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH="$HOME/.local/bin:$PATH"

alias ls='ls --color=auto'
alias dotfiles="git --git-dir=${HOME}/Development/Configurations/dotfiles/.git --work-tree=${HOME}"
PS1='[\u@\h \W]\$ '
