import 'package:process_run/shell_run.dart';

/* what kind of conventions for my globals? camelCase? snakeCase? etc */

/* Done
 - Changed to CapitalCase/Public camelCase
 - nvidia_set_fans
 - nvidia_set_graphics_clock
 -
*/

void NvidiaSetFans(int? _fanIndex, int? _fansVal) {
  var shell = Shell();
  
  final fansParam = "$_fanIndex:$_fansVal";
  /* rmvd sudo on fans */
  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -f $fansParam
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}


/* CLOCKING */

void NvidiaSetGraphicsClock(int _gpuIndex, int _val) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -g $_gpuIndex:$_val
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

void NvidiaSetMemoryClock(int _gpuIndex, int _val) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -m $_gpuIndex:$_val
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}
