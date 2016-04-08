# Use vi mode
set -o vi

# Colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# PS1 prompt
BLUE='\[\033[0;94m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
NO_COLOR='\[\033[0;37m\]'
PS1="${YELLOW}\w${NO_COLOR}${BLUE}\$(__git_ps1)${NO_COLOR}\n${GREEN}\W${NO_COLOR} ${YELLOW}#${NO_COLOR} "

# General aliases
alias ls="gls -lh --color --group-directories-first"
alias grep="ggrep --color"
alias :q="exit"
alias tree="tree -I node_modules"

# Fuzzy finder shell integration
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

# Git bindings
delta62_git_alias() {
    alias $2="$1"
    [[ $3 ]] && __git_complete $2 $3
}

delta62_git_alias "git status"   gs
delta62_git_alias "git branch"   gb   _git_branch
delta62_git_alias "git diff"     gd   _git_diff
delta62_git_alias "git commit"   gc   _git_commit
delta62_git_alias "git pull"     gpl  _git_pull
delta62_git_alias "git push"     gp   _git_push
delta62_git_alias "git add"      ga   _git_add
delta62_git_alias "git log"      gl   _git_log
delta62_git_alias "git checkout" gco  _git_checkout

# Docker stuff
docker-machine-set () {
    local env=$1
    eval $(docker-machine env $env)
    echo $DOCKER_HOST
}
