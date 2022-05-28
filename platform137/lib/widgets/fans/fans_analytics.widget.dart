import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

/* will have to use future builder and can pass down string so I dont have to parse then toString() */
Future<int> nvidia_get_fan_speed(int _gpuIndex) async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_smi.sh', ['-f $_gpuIndex']); /* second arr takes flags and params? */
  print(result.stdout);
  return int.parse(result.stdout);
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
      nvidia_get_fan_speed(0).then((result) {print(result);});
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
