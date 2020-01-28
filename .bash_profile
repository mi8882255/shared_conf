#!/bin/bash


# Git branch in prompt.

# parse_git_branch() {
#   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
# }

# export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# fix history

export HISTCONTROL="ignoredups"
export HISTIGNORE="ls:ps:history"
export HISTFILESIZE=500000

shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# git alias
# galias пше='git'
# galias сруслщге='checkout'
# galias ыефегы='status'


alias gco_clean='~/shared_conf/git_helpers/co_clean.sh'
alias gpush='git push origin HEAD'
alias gcommit='~/shared_conf/git_helpers/commit.sh'
alias notreleased='git log --left-right --cherry-pick --oneline dev...master | grep -v Merge | awk "{ print $3 }" | sort -u'
alias what2push='git diff --stat --cached origin/master'
alias uncommit='git reset --soft HEAD^'

function mosht() {
	mosh $1 tmux a
}


