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
          headline6: TextStyle(fontSize: 18, height: 5, fontWeight: FontWeight.w600),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      
      // nvidia_get_fans();
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'fetching some curls then running them - this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            Column(
              children: [
                Text(
                  'POWER',
                  style: Theme.of(context).textTheme.headline6
                ),
                const SliderWidgetPower(),
              ],
            ),
            Column(
              children: [
                Text(
                  'FANS',
                  style: Theme.of(context).textTheme.headline6
                ),
                const SliderWidgetFans(),
              ],
            ),
           
            Divider(),
            Column(
              children: [
                Text(
                  'GRAPHICS CLOCKING',
                  style: Theme.of(context).textTheme.headline6,
                  ),
                const SliderWidgetGraphics(),
              ],
            ),
            Column(
              children: [
                Text(
                  'MEMORY  CLOCKING',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SliderWidgetMemory(),
              ],
            ),
            // const SliderWidget(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

