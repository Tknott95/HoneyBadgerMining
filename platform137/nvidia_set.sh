#!/bin/bash

# p - power draw                   | NVIDIA-SMI
# t - temp threshold               | NVIDIA-SMI
# f - fan speed                    | NVIDIA-SETTINGS
# m - memory transfer rate offset  | NVIDIA-SETTINGS
# g - graphics clock offset        | NVIDIA-SETTINGS

while getopts 'p:t:f:m:g:' OPTION; do
  case "$OPTION" in
    p)
      nvidia-smi -i 0 -pl $OPTARG ;nvidia-smi -i 1 -pl $OPTARG
      ;;
    t)
      nvidia-smi -i 0 -gtt $OPTARG ;nvidia-smi -i 1 -gtt $OPTARG
      ;;
    f)
      # VAL COMES IN AS <#-of_gpus>:<fan-speed>
      # '20:30' in examples
      which_fan=$(echo $OPTARG | grep -Eo "^[0-9]+")
      fan_val=$(echo $OPTARG | grep -Eo ':.*' | grep -Eo '[0-9]+')
      echo "ARG COMING IN: $OPTARG";
      echo "FAN TARGETING: $which_fan"
      echo "FAN PERCENTAGE: $fan_val"

      nvidia-settings -a GPUFanControlState=1 -a [fan:$which_fan]/GPUTargetFanSpeed=$fan_val
      ;;
    m)
      nvidia-settings -a GPUMemoryTransferRateOffset[2]=$OPTARG
      # nvidia-settings -a [gpu:0]/GPUMemoryTransferRateOffset[2]=$OPTARG
      ;;
    g)
      nvidia-settings -a GPUGraphicsClockOffset[2]=$OPTARG
      # nvidia-settings -a [gpu:0]/GPUGraphicsClockOffset[2]=$OPTARG
      ;;
    ?)
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
# shift "$(($OPTIND -1))"
