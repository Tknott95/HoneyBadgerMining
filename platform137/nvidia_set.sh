#!/bin/bash


while getopts 'p:f:a:' OPTION; do
  case "$OPTION" in
    p)
      nvidia-smi -i 0 -pl $OPTARG ;nvidia-smi -i 1 -pl $OPTARG
      ;;
    f)
      nvidia-smi -q | grep -i fan
      ;;
    a)
      avalue="$OPTARG"
      echo "The value provided is $OPTARG"
      ;;
    ?)
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
# shift "$(($OPTIND -1))"
