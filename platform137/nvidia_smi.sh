#!/bin/bash


# if $1 = 10; then
#   nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader
# fi

# while getopts "t:" OPTION; do
#   case "$OPTION" in
#     t)
#       nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader | echo
#       ;;
#     ?)
#       echo '404'
#       exit 1
#       ;;
#   esac
# done
# shift "$(($OPTIND -1))"


while getopts 'tfa:' OPTION; do
  case "$OPTION" in
    t)
      nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader
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