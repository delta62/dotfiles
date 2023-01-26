# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit; }

set -o vi
set -o ignoreeof
shopt -s histappend

npm_config_prefix="$HOME/.local"

alias ls='ls -lh --group-directories-first --color=auto'
alias ya=yarn
alias pn=pnpm

# PS1 prompt
BLUE='\[\033[0;94m\]'
GREEN='\[\033[0;32m\]'
YELLOW='\[\033[0;33m\]'
NO_COLOR='\[\033[0;37m\]'
PS1="${YELLOW}\w${NO_COLOR}${BLUE}\$(__git_ps1)${NO_COLOR}\n${GREEN}\W${NO_COLOR} ${YELLOW}#${NO_COLOR} "
PATH="$HOME/scripts:$HOME/.fly/bin:$HOME/.local/bin:$PATH"
HISTCONTROL=ignoreboth:erasedups
EDITOR=vim

. "$HOME/.cargo/env"
. /usr/share/git/completion/git-completion.bash
. /usr/share/git/completion/git-prompt.sh
. /usr/share/fzf/key-bindings.bash
. /usr/share/fzf/completion.bash

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
delta62_git_alias "git checkout" gco _git_checkout

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
