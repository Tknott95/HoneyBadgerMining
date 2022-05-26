#!/bin/bash

# p - power draw
# f - fan speed
# m - memory transfer rate offset
# g - graphics clock offset

while getopts 'p:f:m:g:' OPTION; do
  case "$OPTION" in
    p)
      nvidia-smi -i 0 -pl $OPTARG ;nvidia-smi -i 1 -pl $OPTARG
      ;;
    f)
      nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=$OPTARG
      ;;
    m)
      nvidia-settings -a GPUMemoryTransferRateOffset[2]=$OPTARG
      # nvidia-settings -a [gpu:0]/GPUMemoryTransferRateOffset[2]
      ;;
    ?)
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
# shift "$(($OPTIND -1))"
