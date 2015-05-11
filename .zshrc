# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/sam/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias ls='ls -lAhG'
alias grep='grep -i --color'

export PS1=$'\e[0;32m%n\e[0m \e[1;34m%~\e[0m \e[1;32m$ \e[0m'
export RPS1=$'[ %* ]'
