#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh
source $DIR/_help.sh

function main(){
  if [ -z "$1" ]
  then
    printC "Branch name required" cyan
    return
  fi

  if ! $DIR/_clean.sh
  then
    printC "Please commit or stash your current branch changes" cyan
    git status
    return
  fi

  local branch=$(git rev-parse --abbrev-ref HEAD)
  if [ "$branch" != "master" ]
  then
    git checkout master
    git co
    wait ${pid}
    if ! bash $DIR/_clean.sh
    then
      git status
      return
    fi
  fi

  if [ -n "`echo \"$1\" | grep -Poe \"[0-9]+$\"`" ]
  then
    git branch $1
    git checkout $1
    git branch
  else
    getIssueNumber $1
  fi
}

getIssueNumber(){
  while true
  do
    read -p "* Write isue number: " num
    case $num in
      [0-9]* )
        main "$1_$num"
        break;;

      * ) echo "Please write only numbers. It required field.";;
    esac
  done
}

if ! helpMode $@ `basename $0`
then
  main $@
fi
