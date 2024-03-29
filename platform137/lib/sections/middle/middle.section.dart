
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:platform137/widgets/mining/mining_analytics.widget.dart';
import 'package:process_run/shell_run.dart';

import 'package:platform137/globals/mining_globals.dart' as miningGlobals;


/* NEW FLUTTER UPDATE (from 3.0.3 - 3.3.3) BROKE PROG BUTTON. USE NEW ONE */

class MiddleSection extends StatefulWidget {
  const MiddleSection({Key? key}) : super(key: key);

  @override
  State<MiddleSection> createState() => _MiddleSectionState();
}


class _MiddleSectionState extends State<MiddleSection> {
  /* @TODO TURN INTO STATEFUL WIDGET */
  bool isMining = false;
  String poolForMining = 'erg.2miners.com:8888';
  String? dropdownValue;

  final List<String> ergPools = [
    'erg.2miners.com:8888',
    'us-erg.2miners.com:8888',
    'asia-erg.2miners.com:8888',
    'ergo-us-east1.nanopool.org:11111',
    'ergo-us-west1.nanopool.org:11111',
    'ergo-eu1.nanopool.org:11111',
    'ergo-eu2.nanopool.org:11111',
    'ergo-asia1.nanopool.org:11111',
    'ca.ergo.herominers.com:1180',
    'de.ergo.herominers.com:1180',
    'br.ergo.herominers.com:1180',
    'us.ergo.herominers.com:1180',
    'sg.ergo.herominers.com:1180',
    'fi.ergo.herominers.com:1180',
  ];

  @override
  void initState() {
    dropdownValue = ergPools[0];

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    // final AnimatedButtonController animatedButtonController = AnimatedButtonController();

    TextEditingController walletAddrCtrl = TextEditingController();

    // Timer mytimer = Timer.periodic(const Duration(seconds: 5), (timer) {
    //     _fetchLolMiningData();
    // });
    

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        /* @TODO PULL WIDGETS INTO OWN */
        Container(
          decoration: const BoxDecoration(color: Color.fromARGB(24, 255, 253, 249)),
          // padding: new EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            
            children: <Widget>[

              // Center(
              //   child: Padding(
              //     padding:const EdgeInsets.only(top: 0, bottom: 50),
              //     child: Text(
              //       'INSERT MINING DATA BELOW',
              //       style: Theme.of(context).textTheme.headline6
              //     ),
              //   )
              // ),
              // const Divider(),

              // Text("pick your pool", style: Theme.of(context).textTheme.headline5),

              Material(
                child: DropdownButton<String>(
                  hint: const Text("select a mining pool"),
                  value: dropdownValue,
                  // icon: const Icon(Icons.arrow_downward),
                  elevation: 32,
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w300,),
                  iconEnabledColor: const Color.fromARGB(255, 14, 14, 14),
                  onChanged: (String? _newVal) {
                    setState(() {
                      dropdownValue = _newVal!;
                      poolForMining = _newVal;
                    });
                  },
                  items: ergPools
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(value),
                      )),
                    );
                  }).toList(),
                  underline: Container(),
                ),
              ),

              SizedBox(
                width: 700,
                child: Material(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: walletAddrCtrl,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'enter your wallet address',
                        fillColor: Colors.black38
                      ),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Material(
                  child: AnimatedButton( /* Changed animated button type */
                    // controller: animatedButtonController,
                    // color: Colors.greenAccent,
                    text: isMining ? 'already mining' : 'START MINING',
                    selectedText: 'ALREADY MINING',
                    // loadingText: 'MINER RUNNING',
                    // loadedIcon: const Icon(Icons.check, color: Colors.white),
                    // height: 100,
                    // width: 00,
                    isReverse: true,
                    selectedTextColor: Colors.orangeAccent,
                    transitionType: TransitionType.LEFT_TO_RIGHT,
                    // textStyle: submitTextStyle,
                    backgroundColor: Colors.black,
                    borderColor: Colors.white,
                    borderRadius: 50,
                    borderWidth: 2,
                    onPress: () async {
                        /// calling your API here and wait for the response.
                        if (!isMining) { 
                          final walletAddr = walletAddrCtrl.value.text;
                          print("\x1B[1;33m  POOL MINING: \x1B[1;37m $poolForMining\x1B[0m");
                          print("\x1B[1;33m  WALLET ADDR: \x1B[1;37m $walletAddr\x1B[0m");
                          
                          /* PASS DOWN ADDR AND POOL HERE FOR MVP @TODO */
                          miningGlobals.start_mining(poolForMining, walletAddr);
                          isMining = true; 
                        }
                        await Future.delayed(const Duration(seconds: 3)); // simulated your API requesting time.
                        // animatedButtonController.completed(); // call when you get the response
                        // await Future.delayed(Duration(seconds: 5));
                        // animatedButtonController.reset(); // call to reset button animation
                    },
                  ),
                ),
              ),

            ],
          ),
        ),

        

   

        // const Divider(),

        /* @TODO PULL WIDGETS INTO OWN */
        // Center(
        //   child: Text(
        //     'mining here',
        //     style: Theme.of(context).textTheme.headline1
        //   )
        // ),

        const MiningAnalyWidget(),


      ],
    );
  }
}

/* @TODO */
/* pull this function out then call it in here as a start mining */
/* create a way to kill the miner from a global function */
/* hook such to an api to start/stop */
// void start_mining(String _walletAddr, String _pool) async {
//   var shell = Shell();

//   String minerParams = "$_pool;$_walletAddr";
//   print("STARTING MINER: $minerParams");

//   shell.run("""
//     #!/bin/bash
//     sudo ./start_miner.sh $minerParams
//     """).then((result){
//       print(result.toString());
//       print('Shell script done!');
//     }).catchError((onError) {
//       print('Shell.run error!');
//       print(onError);
//     });

//     if() {
//       shell.kill();
//     }
// }