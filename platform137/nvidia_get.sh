#!/bin/bash

# f - is fan speed by provding a gpu-index-#
# l - list amount of GPUs
# m - memory clock
# g - graphics clock
# p - power draw

# @TODO - NEED A SCRIPT TO PULL TEMP LIMIT


# : after the flag makes you have to have a param
while getopts 't:f:a:l:m:p:g:' OPTION; do
  case "$OPTION" in
    t)
      nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader -i $OPTARG
      ;;
    f)
      # nvidia-smi -q | grep -i fan
      # nvidia-smi --query-gpu=fan.speed --format=csv,noheader
      nvidia-smi --query-gpu=fan.speed --format=csv,noheader -i $OPTARG | grep -Eo "^[0-9]+"
      ;;
    l)
      nvidia-smi --list-gpus | wc -l
      ;;
    m)
      nvidia-smi --query-gpu=clocks.mem --format=csv,noheader -i $OPTARG | grep -Eo "^[0-9]+"
      ;;
    p)
      # @TODO - REMOVE REGEX AND MAKE IT FOR A FLOAT INSTEA OF INT  
      nvidia-smi --query-gpu=power.draw --format=csv,noheader -i $OPTARG | grep -Eo "^[0-9]+"
      ;;
    g)
      nvidia-smi --query-gpu=clocks.gr --format=csv,noheader -i $OPTARG | grep -Eo "^[0-9]+"
      ;;
    ?)
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
# shift "$(($OPTIND -1))"
