import 'dart:io';

// import 'package:process_run/which.dart';
import 'package:platform137/widgets/fans/fans.widget.dart';
import 'package:process_run/shell.dart';

import 'package:flutter/material.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';


void main() {
  runApp(const MyApp());
  testing();
  nvidia_get_temp();
  nvidia_get_fans();

  // non_sudo_procs_alt_way();
  // nvidia_set_sudo_fans();
}

void testing() async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./run_smi.sh', ['']); /* second arr takes flags and params? */
  print(result.stdout);
}

void nvidia_get_temp() async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_smi.sh', ['-t']); /* second arr takes flags and params? */
  var gpu_one = int.parse(""+result.stdout[0]+result.stdout[1]+"");
  var gpu_two = ""+result.stdout[2]+result.stdout[3]+"";

  print(result.stdout);
  print("\n gpu_one: " + gpu_one.toString() + "C");
}

void non_sudo_procs_alt_way() {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    sudo ./nvidia_set.sh -p
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

void nvidia_set_power(double powerVal) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    sudo ./nvidia_set.sh -p $powerVal
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

// void nvidia_set_fans(int fansVal) {
//   var shell = Shell();
  
//   final fansParam = "1:"+fansVal.toString();
//   /* rmvd sudo on fans */
//   shell.run("""
//     #!/bin/bash
//     ./nvidia_set.sh -f $fansParam
//     """).then((result){
//       print('Shell script done!');
//     }).catchError((onError) {
//       print('Shell.run error!');
//       print(onError);
//     });
// }

void nvidia_set_graphics_clock(int val) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -g $val
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

void nvidia_set_memory_clock(int val) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -m $val
    """).then((result){
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

void nvidia_get_fans() async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_smi.sh', ['-f']); /* second arr takes flags and params? */
  print(result.stdout);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
      // nvidia_set_power(110);
      // nvidia_set_sudo_fans();
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
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
              children: const [
                Text('P O W E R'),
                SliderWidget(),
              ],
            ),
            Column(
              children: const [
                Text('F A N S'),
                SliderWidgetFans(),
              ],
            ),
           
            Divider(),
            Column(
              children: const [
                Text('G R A P H I C S  C L O C K I N G'),
                SliderWidgetGraphics(),
              ],
            ),
            Column(
              children: const [
                Text('M E M O R Y  C L O C K I N G'),
                SliderWidgetMemory(),
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


class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 110,
      max: 140,
      initialValue: 115,
      innerWidget: (sliderValue) => Center(child: Text(sliderValue.toStringAsFixed(3)+"W"),),
      appearance: CircularSliderAppearance(),
      onChange: (double value) {
        nvidia_set_power(value);
      }
    );
  }
}

// class SliderWidgetFans extends StatefulWidget {
//   const SliderWidgetFans({Key? key}) : super(key: key);

//   @override
//   State<SliderWidgetFans> createState() => _SliderWidgetStateFans();
// }

// class _SliderWidgetStateFans extends State<SliderWidgetFans> {
//   @override
//   Widget build(BuildContext context) {
//     return SleekCircularSlider(
//       min: 30,
//       max: 70,
//       initialValue: 37,
//       innerWidget: (sliderValue) => Center(child: Text(sliderValue.toStringAsFixed(0)+"%"),),
//       appearance: CircularSliderAppearance(),
//       onChange: (double value) {
//         nvidia_set_fans(value.round());
//       }
//     );
//   }
// }


// GRAPHICS - @TODO abstact into widget module
class SliderWidgetGraphics extends StatefulWidget {
  const SliderWidgetGraphics({Key? key}) : super(key: key);

  @override
  State<SliderWidgetGraphics> createState() => _SliderWidgetStateGraphics();
}

class _SliderWidgetStateGraphics extends State<SliderWidgetGraphics> {
  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 0,
      max: 80,
      initialValue: 5,
      innerWidget: (sliderValue) => Center(child: Text(sliderValue.toStringAsFixed(0)+" CLOCK"),),
      appearance: CircularSliderAppearance(),
      onChange: (double value) {
        nvidia_set_graphics_clock(value.round());
      }
    );
  }
}

// MEMORY - @TODO abstact into widget module
class SliderWidgetMemory extends StatefulWidget {
  const SliderWidgetMemory({Key? key}) : super(key: key);

  @override
  State<SliderWidgetMemory> createState() => _SliderWidgetStateMemory();
}

class _SliderWidgetStateMemory extends State<SliderWidgetMemory> {
  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      min: 0,
      max: 650,
      initialValue: 10,
      innerWidget: (sliderValue) => Center(child: Text(sliderValue.toStringAsFixed(0)+" CLOCK"),),
      appearance: CircularSliderAppearance(),
      onChange: (double value) {
        nvidia_set_memory_clock(value.round());
      }
    );
  }
}