#!/bin/bash

#export LC_ALL=C bash
#LANG=en_US.UTF-8 bash
#export LANG='en_US.UTF-8'

# Git branch in prompt.

 parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
 }

 export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

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
alias gpull='git pull --rebase'
alias gcommit='~/shared_conf/git_helpers/commit.sh'
alias g_notreleased='git log --left-right --cherry-pick --oneline dev...master | grep -v Merge | awk "{ print $3 }" | sort -u'
alias g_what2push='git diff --stat --cached origin/`git rev-parse --abbrev-ref HEAD`'
alias g_uncommit='git reset --soft HEAD^'
alias g_reset_orig='git fetch && git reset --hard origin/`git rev-parse --abbrev-ref HEAD`'

function mosht() {
	mosh $1 tmux a
}

function simple_server() {
  echo "SimpleWebStarted on $1"
  while true; do { echo -e 'HTTP/1.1 200 OK\r\n'; } | nc -l $1; done
}
