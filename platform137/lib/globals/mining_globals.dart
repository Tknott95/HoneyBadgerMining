import 'package:process_run/shell_run.dart';
import 'dart:async';
import 'dart:io';

bool stopMiner = false;

void start_mining(String _walletAddr, String _pool) async {
  var shell = Shell();

  String minerParams = "$_pool;$_walletAddr";
  print("STARTING MINER: $minerParams");

  shell.run("""
    #!/bin/bash
    sudo ./start_miner.sh $minerParams
    """).then((result){
      print(result.toString());
      print('Shell script done!');
    }).catchError((onError) {
      print('Shell.run error!');
      print(onError);
    });

    if(stopMiner) {
      shell.kill();
      this.stopMiner = false;
    }
}