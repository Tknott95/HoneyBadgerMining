import 'package:process_run/shell_run.dart';
import 'dart:async';
import 'dart:io';

Future<int> nvidia_get_fan_speed(int _gpuIndex) async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_get.sh', ['-f $_gpuIndex']); /* second arr takes flags and params? */
  print(result.stdout);
  return int.parse(result.stdout);
  // print(int.parse(result.stdout));
}