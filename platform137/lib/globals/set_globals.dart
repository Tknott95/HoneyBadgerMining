import 'package:process_run/shell_run.dart';

/* what kind of conventions for my globals? camelCase? snakeCase? etc */

/* Done
 - Changed to CapitalCase/Public camelCase

* FANS
 - nvidia_set_fans

* CLOCKING
 - nvidia_set_graphics_clock
 - nvidia_set_memory_clock
*/

void NvidiaSetFans(int? _fanIndex, int? _fansVal) {
  var shell = Shell();
  
  final fansParam = "$_fanIndex:$_fansVal";
  /* rmvd sudo on fans */
  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -f $fansParam
    """).then((result){
      print('NvidiaSetFans script done!');
    }).catchError((onError) {
      print('NvidiaSetFans Shell.run error!');
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
      print('NvidiaSetGraphicsClock script done!');
    }).catchError((onError) {
      print('NvidiaSetGraphicsClock Shell.run error!');
      print(onError);
    });
}

void NvidiaSetMemoryClock(int _gpuIndex, int _val) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    ./nvidia_set.sh -m $_gpuIndex:$_val
    """).then((result){
      print('NvidiaSetMemoryClock script done!');
    }).catchError((onError) {
      print('NvidiaSetMemoryClock Shell.run error!');
      print(onError);
    });
}
