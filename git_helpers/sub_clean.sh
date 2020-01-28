#!/bin/bash
./sleep_321.sh

echo "--reset all submodules"
git submodule foreach 'git fetch --all && git clean -f -d && git reset --hard origin/HEAD'

echo '--Update submodules'
#git submodule update --recursive

