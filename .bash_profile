# Feature Detection
OS=win32
[[ `expr $(uname) : Darwin 2>/dev/null` -gt 0 ]] && OS=osx
. "$HOME/.config/d62/bash/$OS.sh"
. "$HOME/.config/d62/bash/git.sh"

# Colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
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

# $PATH
export PATH="${HOME}/.npm-packages/bin:$PATH"

# Aliases
alias ls="ls -lAhG"
alias :fin="find"
alias :q="exit"

# $PS1
BLUE='\[\033[0;94m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
NO_COLOR='\[\033[0;37m\]'
PS1="${YELLOW}\w${NO_COLOR}${BLUE}\$(__git_ps1)${NO_COLOR}\n${GREEN}\W${NO_COLOR} ${YELLOW}#${NO_COLOR} "
