#!/bin/bash

while getopts 'af:' arg; do
  case "$arg" in
    a)
      echo 'Seeding all'
      bin/dustbin command Elixir.Dustbin.Data.ReleaseTasks seed all
      ;;
    f)      
      echo "Seeding file $OPTARG"
      bin/dustbin command Elixir.Dustbin.Data.ReleaseTasks seed $OPTARG
      ;;
    ?)
      echo "Usage:" >&2
      echo "$(basename $0) -a   run all seeds" >&2
      echo "$(basename $0) -f filename  run specific seed file" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

