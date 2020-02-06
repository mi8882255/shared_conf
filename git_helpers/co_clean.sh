#!/bin/bash

not_commited_files_count=`git status --short | wc -l`

if [ $not_commited_files_count -gt 0 ]; then
    echo "This changes can be lost:"
    git status --short
    read -p "Are you sure? " -n 1 -r
    echo ''
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        echo '-Cancelled-'
        exit 1
    fi
fi

echo '--Fetch'
git fetch --all

echo '--clean'
git clean -f -f -d -x
git reset --hard

sleep 1

echo "--Checkout $1"
git checkout $1

echo '--Reset'
git reset --hard origin/$1

#echo "--update submodules"
#git init
#git submodule foreach git fetch
#git submodule foreach git reset --hard origin/master
#git submodule update --recursive

