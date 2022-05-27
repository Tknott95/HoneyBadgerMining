import 'dart:io';

// import 'package:process_run/which.dart';
import 'package:platform137/widgets/fans/fans.widget.dart';
import 'package:platform137/widgets/graphics/graphics.widget.dart';
import 'package:platform137/widgets/memory/memory.widget.dart';
import 'package:platform137/widgets/power/power.widget.dart';
import 'package:process_run/shell.dart';

import 'package:flutter/material.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';


void main() {
  runApp(const MyApp());
  nvidia_get_temp();
  nvidia_get_fans();

  // nvidia_set_sudo_fans();
}

// void testing() async {
//   // List all files in the current directory in UNIX-like systems.
//   var result = await Process.run('./run_smi.sh', ['']); /* second arr takes flags and params? */
//   print(result.stdout);
// }

void nvidia_get_temp() async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_smi.sh', ['-t']); /* second arr takes flags and params? */
  var gpu_one = int.parse(""+result.stdout[0]+result.stdout[1]+"");
  var gpu_two = ""+result.stdout[2]+result.stdout[3]+"";

  print(result.stdout);
  print("\n gpu_one: " + gpu_one.toString() + "C");
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

void nvidia_get_fans() async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_smi.sh', ['-f']); /* second arr takes flags and params? */
  print(result.stdout);
}

/* BLACK - w900
/  SEMIBOLD - w600
/  LIGHT - w300
*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Row(
  children: <Widget>[
    Expanded(
      child: Column(
          children: <Widget>[
            SizedBox(
              // heightFactor: .3,
              // widthFactor: 1,
              height: 180,
              width: double.infinity,
              
              child: Container(
               decoration: const BoxDecoration(color: Colors.green),
               child: const Text('kjsalkjasljkasljk',),
              ),
            ),
            Expanded(
              flex: 1,
              
              child: Container(
               color: const Color.fromARGB(145, 115, 115, 124),
               child: const Text('fghjfghjhgjfhg'),
               width: double.infinity,
              ),
            )
          ],
      ),
      flex: 6,
    ),
    Expanded(
      child: Container(
        decoration: const BoxDecoration(color: Colors.green),
      ),
      flex: 4,
    ),
    
  ],
);
    
    // Column(
    //       children: <Widget>[
    //         SizedBox(
    //           // heightFactor: .3,
    //           // widthFactor: 1,
    //           height: 180,
    //           width: double.infinity,
              
    //           child: Container(
    //            color: const Color.fromARGB(0, 202, 202, 206),
    //            child: const Text('kjsalkjasljkasljk',),
    //           ),
    //         ),
    //         Expanded(
    //           flex: 1,
              
    //           child: Container(
    //            color: const Color.fromARGB(145, 115, 115, 124),
    //            child: const Text('fghjfghjhgjfhg'),
    //            width: double.infinity,
    //           ),
    //         )
    //       ],
    // );
  }
}

