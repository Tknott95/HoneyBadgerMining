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
  final gpuIndex;
  const FanAnalyticsWidget({Key? key, @required this.gpuIndex}) : super(key: key);

  @override
  State<FanAnalyticsWidget> createState() => FanAnalyticsWidgetState();
}


class FanAnalyticsWidgetState extends State<FanAnalyticsWidget> {
  String gpuFanSpeed = '00';
  int gpuIndex = 0;
  

  @override
  void initState() {
    gpuIndex = widget.gpuIndex;
    gpuFanSpeed = nvidia_get_fan_speed(gpuIndex).toString();

    Timer mytimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      nvidia_get_fan_speed(gpuIndex).then((result) {print("gpu_($gpuIndex) fan speed: $result"); gpuFanSpeed=result.toString();});
      // nvidia_get_fan_speed(1).then((result) {print("gpu_two fan speed: $result");});

      gpuFanSpeed = nvidia_get_fan_speed(gpuIndex).toString();
      print("gpu_one fan speed: $gpuFanSpeed");
      setState(() { });

        //mytimer.cancel() //to terminate this timer
     });
    
    // print('timer: $mytimer');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 100, width: 250, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$gpuFanSpeed",
                style: Theme.of(context).textTheme.headline1
              ),
              Text('%', style: Theme.of(context).textTheme.bodyText2)
            ],
          ),
          Text('FAN SPEED', style: Theme.of(context).textTheme.bodyText2),      
        ],
      )
    );
  }
}
