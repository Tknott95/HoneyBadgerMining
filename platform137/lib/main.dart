import 'dart:io';
// import 'dart:convert';

// import 'package:process_run/which.dart';
import 'package:platform137/providers/gpu.provider.dart';
import 'package:platform137/sections/middle/middle.section.dart';
import 'package:platform137/sections/right/right.section.dart';
import 'package:platform137/sections/top/top.section.dart';

import 'package:platform137/globals/set_globals.dart' as gbl;
import 'package:platform137/router/main.router.dart' as rtr;


import 'package:process_run/shell.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* @TODO - refactor api serve code into another folder/file */

const bool IS_MINING = false;

void main() async {
  if (IS_MINING) start_mining(); /* OLD MINER SCRIPT */
  runApp(const MyApp());
  print("\x1B[1;33m  IS_MINING: \x1B[1;37m $IS_MINING\x1B[0m");
 
  /* @TODO - code itself needs to be cleaned yet below is an important first step */
  /* @TODO - refactor api serve code into another folder/file */
  rtr.serveAPI();
}


/* @TODO MAKE THESE GLOBAL FUNCS */
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

Future<int> nvidia_set_gpu_count_alt (context) async {
  // List all files in the current directory in UNIX-like systems.
  var result = await Process.run('./nvidia_get.sh', ['-l']); /* second arr takes flags and params? */
  final gpuCount = int.parse(result.stdout);
  print('SETTING GPU COUNT: $gpuCount');
  Provider.of<GPUProvider>(context, listen: false).setAmtOfGPUS(gpuCount);
  // GPUProvider().setAmtOfGPUS(gpuCount);

  final newGPUCount = Provider.of<GPUProvider>(context, listen: false).numOfGPUs;
  print('GLOBAL GPU COUNT: $newGPUCount');

  return newGPUCount;
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
  int gpuOne = int.parse(""+result.stdout[0]+result.stdout[1]+"");

  print("\n gpu_one: " + gpuOne.toString() + "C");
  return gpuOne;
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
          headline2: TextStyle(fontSize: 50, fontWeight: FontWeight.w400,  
            shadows: [
              Shadow( // bottomLeft
                offset: Offset(-.5, -.5),
                /* change shadow based on temp ? @TODO ? */
                color: Color.fromARGB(255, 0, 0, 0)
              ),
              // Shadow( // bottomRight
              //   offset: Offset(1.5, -1.5),
              //   color: Color.fromARGB(255, 0, 16, 85)
              // ),
              // Shadow( // topRight
              //   offset: Offset(1.5, 1.5),
              //   color: Color.fromARGB(255, 0, 39, 97)
              // ),
              // Shadow( // topLeft
              //   offset: Offset(-1.5, 1.5),
              //   color: Color.fromARGB(255, 0, 6, 90)
              // ),
            ]
          ),
          headline3: TextStyle(fontSize: 50, fontWeight: FontWeight.w400,  
            shadows: [
              Shadow( // bottomLeft
                // offset: Offset(-.5, -.5),
                /* change shadow based on temp ? @TODO ? */
                // color: Color.fromARGB(255, 72, 69, 255)
              ),
            ]
          ),
          headline4: TextStyle(fontSize: 50, fontWeight: FontWeight.w400,  
            shadows: [
              Shadow( // bottomLeft
                offset: Offset(-.5, -.5),
                color: Color.fromARGB(255, 150, 204, 159)
              ),
            ]
          ),
          // headline5: TextStyle(fontSize: 50, fontWeight: FontWeight.w400,  
          //   shadows: [
          //     Shadow( // bottomLeft
          //       offset: Offset(-.5, -.5),
          //       color: Color.fromARGB(255, 150, 204, 159)
          //     ),

          //   ]
          // ),
          headline6: TextStyle(fontSize: 8, height: 5, fontWeight: FontWeight.w900),
          headline5: TextStyle(fontSize: 8, height: 5, fontWeight: FontWeight.w400),
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
    
     // print('GPU COUNT ###    ($gpuCount)');
    nvidia_set_gpu_count(context);
    /* nest this as it is async and not waiting for an update to call without listen which is shit on computation */

    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
              children: <Widget>[
                const TopSection(),
                Expanded(
                  flex: 1,
                  
                  child: Container(
                  color: const Color.fromRGBO(250, 250, 250, 1), /* matching forms */
                  width: double.infinity,
                  child: const MiddleSection(),
                  ),
                )
              ],
          ),
          flex: 73,
        ),
        const Expanded(
          flex: 27,
          child: RightSection()
        ),
        
      ],
    );
  }
}
