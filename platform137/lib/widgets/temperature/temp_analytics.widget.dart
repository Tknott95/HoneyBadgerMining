import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';


/* RENAME THIS TO temp_analytics or something */
/* will have to use future builder and can pass down string so I dont have to parse then toString() */
Future<int> nvidia_get_fan_speed(int _gpuIndex) async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_get.sh', ['-t $_gpuIndex']); /* second arr takes flags and params? */
  print(result.stdout);
  return int.parse(result.stdout);
  // print(int.parse(result.stdout));
}

class TempAnalyticsWidget extends StatefulWidget {
  final gpuIndex;
  const TempAnalyticsWidget({Key? key, @required this.gpuIndex}) : super(key: key);

  @override
  State<TempAnalyticsWidget> createState() => TempAnalyticsWidgetState();
}


class TempAnalyticsWidgetState extends State<TempAnalyticsWidget> {
  String gpuTemp = '00';
  var gpuIndex;

  @override
  void initState() {
    gpuIndex = widget.gpuIndex;
    nvidia_get_fan_speed(gpuIndex).then((result) {gpuTemp = result.toString(); print("gpu_($gpuIndex) gpu temp: $result");});

    Timer mytimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      nvidia_get_fan_speed(gpuIndex).then((result) {gpuTemp = result.toString(); print("gpu_($gpuIndex) gpu temp: $result");});

      print("gpu_($gpuIndex) gpu temp: $gpuTemp");
      setState(() { });

      // mytimer.cancel() //to terminate this timer
     });
    
    // print('timer: $mytimer');
    super.initState();
  }

  /* needs to become a stream builder probably */
  @override
  Widget build(BuildContext context) {

    final int gpuTempVal = int.parse(gpuTemp);
    return SizedBox(height: 100, width: 250, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (gpuTempVal < 35) Text(
                gpuTemp,
                style: Theme.of(context).textTheme.headline3?.copyWith(color: Color.fromARGB(255, 1, 73, 4)),
              ) else if (gpuTempVal > 35 && gpuTempVal < 60) Text(
                gpuTemp,
                style: Theme.of(context).textTheme.headline3?.copyWith(color: Color.fromARGB(255, 3, 20, 119)),
              ) else Text(
                gpuTemp,
                style: Theme.of(context).textTheme.headline3?.copyWith(color: Color.fromARGB(255, 15, 80, 2)),
              ),
              Text('°C', style: Theme.of(context).textTheme.bodyText2)
            ],
          ),
          Text('GPU_$gpuIndex TEMP', style: Theme.of(context).textTheme.bodyText2),      
        ],
      )
    );
  }
}
