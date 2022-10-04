import 'package:process_run/shell_run.dart';
import 'dart:async';
import 'dart:io';

Future<int> nvidia_get_fan_speed(int _gpuIndex) async {
  var result = await Process.run('./nvidia_get.sh', ['-f $_gpuIndex']); /* second arr takes flags and params? */
  print(result.stdout);
  return int.parse(result.stdout);
}

Future<int> nvidia_get_gpu_temp(int _gpuIndex) async {
  var result = await Process.run('./nvidia_get.sh', ['-t $_gpuIndex']); /* second arr takes flags and params? */
  print(result.stdout);
  return int.parse(result.stdout);
}


Future<int>  nvidia_get_gpu_count() async {
  var result = await Process.run('./nvidia_get.sh', ['-l']); /* second arr takes flags and params? */
  final _gpuCount = int.parse(result.stdout);
  
  return _gpuCount;
}

/* NEED GPU POWER - NEED GPU MEMORY */
