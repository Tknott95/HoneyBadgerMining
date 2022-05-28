import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:process_run/shell_run.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

int nvidia_get_fan_speed(int _gpuIndex) async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_smi.sh', ['-f $_gpuIndex']); /* second arr takes flags and params? */
  print(result.stdout);
  // print(int.parse(result.stdout));
}

class FanAnalyticsWidget extends StatefulWidget {
  const FanAnalyticsWidget({Key? key}) : super(key: key);

  @override
  State<FanAnalyticsWidget> createState() => FanAnalyticsWidgetState();
}

class FanAnalyticsWidgetState extends State<FanAnalyticsWidget> {
  String gpuFanSpeed = '';
  @override
  void initState() {
    Timer mytimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      gpuFanSpeed = nvidia_get_fan_speed(0).toString();
      print("gpu_one fan speed: $gpuFanSpeed");

        //mytimer.cancel() //to terminate this timer
     });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "GPU_ONE: $gpuFanSpeed",
          style: Theme.of(context).textTheme.headline6
        ),
                
      ],
    );
  }
}
