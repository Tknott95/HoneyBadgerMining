#!/bin/bash

# f - is fan speed by provding a gpu-index-#
# l - list amount of GPUs

while getopts 't:f:a:' OPTION; do
  case "$OPTION" in
    t)
      nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader
      ;;
    f)
      # nvidia-smi -q | grep -i fan
      # nvidia-smi --query-gpu=fan.speed --format=csv,noheader
      nvidia-smi --query-gpu=fan.speed --format=csv,noheader -i $OPTARG | grep -Eo "^[0-9]+"
      ;;
    l)
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
