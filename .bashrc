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

# Git
source ~/.git-completion.sh

d62_git_alias() {
    alias $2="$1"
    if [ $3 ]
    then
        __git_complete $2 $3
    fi
}
d62_git_alias "git branch" gb    _git_branch
d62_git_alias "git status" gs
d62_git_alias "git commit" gc    _git_commit
d62_git_alias "git push"   gp    _git_push
d62_git_alias "git pull"   gpl   _git_pull
d62_git_alias "git add"    ga    _git_add
d62_git_alias "git log"    gl    _git_log
d62_git_alias "git diff"   gd    _git_diff
d62_git_alias "git checkout" gco _git_checkout
