#!/bin/bash


while getopts 'pfa:' OPTION; do
  case "$OPTION" in
    p)
      sudo nvidia-smi -i 0 -pl 110;  sudo nvidia-smi -i 1 -pl 105 
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
