import 'package:process_run/shell_run.dart';

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
