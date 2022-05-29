import 'dart:io';

// import 'package:process_run/which.dart';
import 'package:platform137/providers/gpu.provider.dart';
import 'package:platform137/widgets/fans/fans.widget.dart';
import 'package:platform137/widgets/fans/fans_analytics.widget.dart';
import 'package:platform137/widgets/graphics/graphics.widget.dart';
import 'package:platform137/widgets/memory/memory.widget.dart';
import 'package:platform137/widgets/power/power.widget.dart';
import 'package:platform137/widgets/temperature/temp_thresh.widget.dart';
import 'package:process_run/shell.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(const MyApp());
  nvidia_get_temp();
  // nvidia_set_gpu_count();

  // nvidia_get_fan_speed(0); /* async error is herem, will be fixed once in an async return widget */
  // nvidia_get_fan_speed(1); /* async error is herem, will be fixed once in an async return widget */

  // nvidia_set_sudo_fans();
}

// void testing() async {
//   // List all files in the current directory in UNIX-like systems.
//   var result = await Process.run('./run_smi.sh', ['']); /* second arr takes flags and params? */
//   print(result.stdout);
// }

void nvidia_get_temp() async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_get.sh', ['-t']); /* second arr takes flags and params? */
  var gpu_one = int.parse(""+result.stdout[0]+result.stdout[1]+"");


  print(result.stdout);
  print("\n gpu_one: " + gpu_one.toString() + "C");
}

void nvidia_set_gpu_count(context) async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_get.sh', ['-l']); /* second arr takes flags and params? */
  final gpuCount = int.parse(result.stdout);
  print('SETTING GPU COUNT: $gpuCount');
  Provider.of<GPUProvider>(context, listen: false).setAmtOfGPUS(gpuCount);
  // GPUProvider().setAmtOfGPUS(gpuCount);

  final newGPUCount = Provider.of<GPUProvider>(context, listen: false).numOfGPUs;
  print('GLOBAL GPU COUNT: $newGPUCount');

}

void start_mining() async {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    sudo ./get_lolminer.sh
    """).then((result){
      print(result.toString());
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

/* NOT USING ANYMORE - REMOVE LATER JUST IN CASE */
// void nvidia_set_sudo_fans() async {
//   var stdinForShell = sharedStdIn;
//   var shellEnv = ShellEnvironment()..aliases['sudo'] = 'sudo --stdin';
//   var shell = Shell(
//     stdin: sharedStdIn,
//     environment: shellEnv,
//     throwOnError: false
//   );

//   /* @NOTE breaks after functionfires once bcz of terminate */

//   await shell.run('sudo ./nvidia_set.sh -p');
//   await stdinForShell.terminate();
// }

Future<int> nvidia_get_temp_alt() async {
  var result = await Process.run('./nvidia_smi.sh', ['-t']); /* second arr takes flags and params? */
  int gpu_one = int.parse(""+result.stdout[0]+result.stdout[1]+"");

  print("\n gpu_one: " + gpu_one.toString() + "C");
  return gpu_one;
}

// void nvidia_get_fan_speed(int _gpuIndex) async {
//   // List all files in the current directory in UNIX-like systems.
//   var result = await Process.run('./nvidia_smi.sh', ['-f $_gpuIndex']); /* second arr takes flags and params? */
//   print(result.stdout);
//   // print(int.parse(result.stdout));
// }

/* BLACK - w900
/  SEMIBOLD - w600
/  LIGHT - w300
*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: ((context) => GPUProvider()), 
      )
    ],
    child:MaterialApp(
      title: 'Platform137',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 50, fontWeight: FontWeight.w800),
          headline6: TextStyle(fontSize: 8, height: 5, fontWeight: FontWeight.w900),
          bodyText1: TextStyle(fontSize: 10, height: 1, fontWeight: FontWeight.w600),
        ),
      ),
      home: const MyHomePage(title: 'Platform137'),
    ))
    ;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // @override
  // void initState() {
  //   nvidia_set_gpu_count();

  //   setState(() { });

    
  //   // print('timer: $mytimer');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    nvidia_set_gpu_count(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
              children: <Widget>[
                Center(
                  child: SizedBox(
                    // heightFactor: .3,
                    // widthFactor: 1,
                    height: 180,
                    width: double.infinity,
                    
                    child: Container(
                      decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 253, 249)),
                      child: Center(
                        child: Row /*or Column*/( 
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  <Widget>[
                            Icon(Icons.star, size: 50),
                            Icon(Icons.star, size: 50),
                            // Icon(Icons.star, size: 50),
                            const SizedBox(height: 100, width: 100, 
                              child: FanAnalyticsWidget(gpuIndex: 0)
                            ),
                            const SizedBox(height: 100, width: 100, 
                              child: FanAnalyticsWidget(gpuIndex: 1)
                            ),
                            Text(
                              'platform137',
                              style: Theme.of(context).textTheme.headline1
                            ),
                            Icon(Icons.star, size: 50),
                            Icon(Icons.star, size: 50),
                            Icon(Icons.star, size: 50),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  
                  child: Container(
                  color: Color.fromARGB(255, 130, 130, 130),
                  child: Center(
                      child: Text(
                        'mining here',
                          style: Theme.of(context).textTheme.headline1
                        )
                      ),
                  width: double.infinity,
                  ),
                )
              ],
          ),
          flex: 73,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SliderWidgetPower(),
                SliderWidgetTempThresh(),
                Divider(),
                SliderWidgetFans(),
                Divider(),
                SliderWidgetMemory(),
                SliderWidgetGraphics()
              ]
            ),
          ),
          flex: 27,
        ),
        
      ],
    );
  }
}
