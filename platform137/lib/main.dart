import 'dart:io';
import 'dart:convert';

// import 'package:process_run/which.dart';
import 'package:platform137/providers/gpu.provider.dart';
import 'package:platform137/sections/middle/middle.section.dart';
import 'package:platform137/sections/right/right.section.dart';
import 'package:platform137/sections/top/top.section.dart';

import 'package:platform137/globals/set_globals.dart' as gbl;

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as rtr;
import 'package:shelf/shelf_io.dart' as io;

import 'package:process_run/shell.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


const bool IS_MINING = false;

void main() async {
  if (IS_MINING) start_mining(); /* OLD MINER SCRIPT */
  runApp(const MyApp());
  print("\x1B[1;33m  IS_MINING: \x1B[1;37m $IS_MINING\x1B[0m");

  serveAPI();
}

/* GETS with header auth works perfect for mvp */
/* will add future sec after MVP */
/* wrap header auth instead of using in each function after MVP */
void serveAPI() async {
  var app = rtr.Router();

  const String TOP_SECRET_KEY = "top_secret_key<kdkljsdljkdsjklkljsdkjlsdkljsdjklsdjklkjlsdjksdkjlsdkjlklsjdkjlsdljk>";


  // EXAMPLES
  // curl -H "alice: top_secret_key<kdkljsdljkdsjklkljsdkjlsdkljsdjklsdjklkjlsdjksdkjlsdkjlklsjdkjlsdljk>" localhost:8080/api
  // curl -H "alice: top_secret_key<kdkljsdljkdsjklkljsdkjlsdkljsdjklsdjklkjlsdjksdkjlsdkjlklsjdkjlsdljk>" localhost:8080/api/setFans/0/50
  
  app.get('/api', (Request request) {
    var response = {
      'message': 'API is alive',
      'api_routes': ['/api', '/api/id/<id>', '/api/setFans/<fanIndex>/<fanVal>'
      ]
    };

    final reqHeaders = request.headers['alice'];

    if (reqHeaders == TOP_SECRET_KEY) {
      print("\n HEADERS: $reqHeaders \n");
      print("\n HEADERS: $reqHeaders \n");

      print("\n\n This function will fire from over the wire!");
      return Response.ok(jsonEncode(response));
    } else {
      return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
    }
  });

  app.get('/api/id/<id>', (Request request, String _id) {
    final parseID = int.tryParse(_id);

    final jsonData = '{ "fanIndex": "$_id fanIndex", "alice": "$_id in wonderland" }';

    print("\n\n $_id This function will fire from over the wire!");
    return Response.ok(jsonData);
  });

  app.get('/api/setFans/<fanIndex>/<fanVal>', (Request request, String _fanIndex, String _fanVal) {
    var parseID = int.tryParse(_fanIndex);
    final parseFanVal = int.tryParse(_fanVal);

    final reqHeaders = request.headers['alice'];

    print('\n SET FANS HIT\n SET FANS HIT\n SET FANS HIT\n SET FANS HIT');
    if (parseID == null) parseID = 0;
    /* int instead of double */

  
    if (reqHeaders == TOP_SECRET_KEY) {
      print("\n HEADERS: $reqHeaders \n");
      print("\n HEADERS: $reqHeaders \n");

      gbl.NvidiaSetFans(parseID, parseFanVal);

      final jsonData = '{ "fanIndex": "$_fanIndex", "fanVal": "$_fanVal" }';

      print("\n\n $_fanIndex is the fanIndex changing fans to  $_fanVal%");
      return Response.ok(jsonData);
    } else {
      return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
    }
  });

  app.get('/api/setGraphicsClock/<gpuIndex>/<gpuVal>', (Request request, String _gpuIndex, String _gpuVal) {
    var parseID = int.tryParse(_gpuIndex);
    final parseGPUVal = int.tryParse(_gpuVal);

    final reqHeaders = request.headers['alice'];
    if (parseID == null) parseID = 0;
    /* int instead of double */
  
    if (reqHeaders == TOP_SECRET_KEY) {
      print("\n HEADERS: $reqHeaders \n");
      print("\n HEADERS: $reqHeaders \n");

      gbl.NvidiaSetGraphicsClock(parseID, parseGPUVal);

      final jsonData = '{ "gpuIndex": "$_gpuIndex", "gpuVal": "$_gpuVal" }';

      print("\n\n $_gpuIndex is the gpuIndex changing clock val to  $_gpuVal%");
      return Response.ok(jsonData);
    } else {
      return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
    }
  });

  var server = await io.serve(app, '192.168.0.8', 8080);
}

// void testing() async {
//   // List all files in the current directory in UNIX-like systems.
//   var result = await Process.run('./run_smi.sh', ['']); /* second arr takes flags and params? */
//   print(result.stdout);
// }

/* DEPRECATED */
// void nvidia_get_temp() async {
//   // List all files in the current directory in UNIX-like systems.
//   var result = await Process.run('./nvidia_get.sh', ['-t']); /* second arr takes flags and params? */
//   var gpu_one = int.parse(""+result.stdout[0]+result.stdout[1]+"");


//   print(result.stdout);
//   print("\n gpu_one: " + gpu_one.toString() + "C");
// }

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
