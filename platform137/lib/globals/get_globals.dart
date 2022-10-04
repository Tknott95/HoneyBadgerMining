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

Future<int>  nvidia_get_power_draw(int _gpuIndex) async {
  var result = await Process.run('./nvidia_get.sh', ['-p $_gpuIndex']); /* second arr takes flags and params? */
  final _powerDraw = int.parse(result.stdout);
  
  return _powerDraw;
}

Future<int> nvidia_get_memory_clock(int _gpuIndex) async {
  var result = await Process.run('./nvidia_get.sh', ['-m $_gpuIndex']); /* second arr takes flags and params? */
  final _memClock = int.parse(result.stdout);
  
  return _memClock;
}

/* NEED GPU POWER - NEED GPU MEMORY */
