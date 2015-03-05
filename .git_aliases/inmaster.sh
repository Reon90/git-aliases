#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  local branch=$(git rev-parse --abbrev-ref HEAD)

  git pull origin $branch:$branch
  wait $pid
  if bash _clean.sh
  then
    git checkout master
    wait $pid
    git pull origin master:master
    wait $pid
    if bash _clean.sh
    then
      git merge $branch
      wait $pid
      if bash _clean.sh
      then
        git push origin master:master
      fi
    fi
  else
    git status
  fi
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
