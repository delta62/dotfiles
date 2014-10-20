# Colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# Add homebrew to path
export PATH="/usr/local/bin:$PATH"

# Environment variables
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0m\]'

# General aliases
alias ls="ls -l -G"
alias grep="grep -i --color"

# Git aliases
alias gb="git branch"
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias gpl="git pull"
alias ga="git add"
alias gl="git log"
alias gd="git diff"
