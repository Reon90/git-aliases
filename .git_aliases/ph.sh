#!/usr/bin/env bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $DIR/_printColor.sh

name="ph"
description="Git push alias"

function main(){
  local branch=$(git rev-parse --abbrev-ref HEAD)
  if [ -z "$1" ]
  then
    git push origin $branch:$branch
  else
    git push origin $1:$1
  fi;
}

for i in $@
do
  if [ "$i" == "-h" ]
  then
    helpMode=true;
  fi;
done

if [ -n "$helpMode" ]
then
  printC $name
  echo $description
  printC $DIR/$name.sh gray
else

  if [ -z "$installMode" ]
  then
    main $@
  fi

fi