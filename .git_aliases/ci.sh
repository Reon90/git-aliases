#!/usr/bin/env bash

name="ci"
description="ci description"

function main(){
  echo "ci"
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
  echo $name
  echo $description
else

  if [ -z "$installMode" ]
  then
    main $@
  fi

fi