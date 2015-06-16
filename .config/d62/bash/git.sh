# Git
. ~/.git-completion.sh
. ~/.git-prompt.sh

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
