#!/bin/bash
STATUS="clean"

console_log_count=`git diff | grep -e 'console\.log' | wc -l`
if [ $console_log_count -gt 0 ]; then
    echo "WARNING:console.log"
    STATUS="bad"
fi

if [[ ! "$1" =~ ^CEX-[0-9]+.*$ ]]; then
    echo "WARNING: wrong commit message"
    STATUS="bad"
fi

if [ "$STATUS" == "bad" ]; then
    read -p " Continue? " -n 1 -r
    echo ''
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo '-Cancelled-'
        exit 1
    fi
fi

git commit -am \"$1\"


