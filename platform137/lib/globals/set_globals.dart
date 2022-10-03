import 'package:process_run/shell_run.dart';

/* what kind of conventions for my globals? camelCase? snakeCase? etc */

/* Done
 - Changed to CapitalCase/Public camelCase

* FANS
 - nvidia_set_fans

* CLOCKING
 - nvidia_set_graphics_clock
 - nvidia_set_memory_clock

* MISC
 - nvidia_set_power
 - nvidia_set_temp_threshold
*/

/* if null set val - set max clock vals for safety */

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
void NvidiaSetGraphicsClock(int? _gpuIndex, int? _val) {
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

void NvidiaSetMemoryClock(int? _gpuIndex, int? _val) {
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

/* POWER */
void NvidiaSetPowerDraw(int? _gpuIndex, double? _powerVal) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    sudo ./nvidia_set.sh -p $_gpuIndex:$_powerVal
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}

void NvidiaSetTempThreshold(int? _gpuIndex, int? _val) {
  var shell = Shell();

  shell.run("""
    #!/bin/bash
    sudo ./nvidia_set.sh -t $_gpuIndex:$_val
    """).then((result){
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });
}
