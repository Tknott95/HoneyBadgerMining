#!/bin/bash

# p - power draw                   | NVIDIA-SMI
# t - temp threshold               | NVIDIA-SMI
# f - fan speed                    | NVIDIA-SETTINGS
# m - memory transfer rate offset  | NVIDIA-SETTINGS
# g - graphics clock offset        | NVIDIA-SETTINGS

while getopts 'p:t:f:m:g:' OPTION; do
  case "$OPTION" in
    p)
      which_gpu=$(echo $OPTARG | grep -Eo "^[0-9]+")
      power_val=$(echo $OPTARG | grep -Eo ':.*' | grep -Eo '[0-9]+.[0-9]+')
      # POWER COMES IN AS FLOAT SO REGEX IT A TAD DIFF
      | 
      nvidia-smi -i $which_gpu -pl $power_val
      ;;
    t)
      which_gpu=$(echo $OPTARG | grep -Eo "^[0-9]+")
      temp_val=$(echo $OPTARG | grep -Eo ':.*' | grep -Eo '[0-9]+')
      nvidia-smi -i $which_gpu -gtt $temp_val
      ;;
    f)
      # VAL COMES IN AS <#-of_gpus>:<fan-speed>
      # '20:30' in examples
      which_fan=$(echo $OPTARG | grep -Eo "^[0-9]+")
      fan_val=$(echo $OPTARG | grep -Eo ':.*' | grep -Eo '[0-9]+')
      echo "ARG COMING IN: $OPTARG";
      echo "FAN TARGETING: $which_fan"
      echo "FAN PERCENTAGE: $fan_val"

      # nvidia-settings -a GPUFanControlState=1 -a [fan:$which_fan]/GPUTargetFanSpeed=$fan_val
      nvidia-settings -a GPUFanControlState=1 -a GPUTargetFanSpeed=$fan_val
      ;;
    m)
      which_gpu=$(echo $OPTARG | grep -Eo "^[0-9]+")
      clock_val=$(echo $OPTARG | grep -Eo ':.*' | grep -Eo '[0-9]+')
      nvidia-settings -a [gpu:$which_gpu]/GPUMemoryTransferRateOffset[2]=$clock_val
      # nvidia-settings -a [gpu:0]/GPUMemoryTransferRateOffset[2]=$OPTARG
      ;;
    g)
      which_gpu=$(echo $OPTARG | grep -Eo "^[0-9]+")
      clock_val=$(echo $OPTARG | grep -Eo ':.*' | grep -Eo '[0-9]+')
      nvidia-settings -a [gpu:$which_gpu]/GPUGraphicsClockOffset[2]=$clock_val
      # nvidia-settings -a [gpu:0]/GPUGraphicsClockOffset[2]=$OPTARG
      ;;
    ?)
      echo "script usage: $(basename \$0) [-l] [-h] [-a somevalue]" >&2
      exit 1
      ;;
  esac
done
# shift "$(($OPTIND -1))"
