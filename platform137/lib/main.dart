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
          headline6: TextStyle(fontSize: 18, height: 5, fontWeight: FontWeight.w400),
          bodyText1: TextStyle(fontSize: 14, height: 1, fontWeight: FontWeight.w900),
        ),
      ),
      home: const MyHomePage(title: 'Platform137'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[

            // Text(
            //   'GPUs control room',
            //   style: Theme.of(context).textTheme.headline6,
            // ),
            SliderWidgetPower(),
            SliderWidgetFans(),

            Divider(),

            SliderWidgetGraphics(),
            SliderWidgetMemory(),

          ],
        ),
      ),

    );
  }
}

