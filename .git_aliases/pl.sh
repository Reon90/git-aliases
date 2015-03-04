#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh;

function main(){
  local branch=$(git rev-parse --abbrev-ref HEAD)
  if [ -z "$1" ]
  then
    git pull origin $branch
  else
    git pull origin $1:$1
  fi;
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
