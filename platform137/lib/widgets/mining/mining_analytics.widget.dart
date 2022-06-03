import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:platform137/models/lolminer.model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MiningAnalyWidget extends StatefulWidget {
  const MiningAnalyWidget({Key? key}) : super(key: key);

  @override
  _MiningAnalyWidgetState createState() {
    return _MiningAnalyWidgetState();
  }
}

// @TODO modularize this
class _MiningAnalyWidgetState extends State<MiningAnalyWidget> {
  final StreamController<Lolminer> _streamCtrl = StreamController();


  @override
  void dispose() {
    _streamCtrl.close();
  }

  @override
  void initState() {


    Timer mytimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchLolMiningData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Lolminer>(
      stream: _streamCtrl.stream,
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting: return Center(child: Column(
            children: [
              Text(
                'WAITING FOR MINING TO BEGIN - START MINING ABOVE TO UNLOCK',
                style: Theme.of(context).textTheme.headline6
              ),
               SpinKitDancingSquare(
                size: 100,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? const Color.fromARGB(255, 179, 179, 179) : const Color.fromARGB(255, 220, 220, 219),
                    ),
                  );
                },
              ),
            ],
          ));
          default: if(snapshot.hasError){
            return Text(
              'Waiting for mining server...', style: Theme.of(context).textTheme.headline1);
          } else {
            return analyticsWidget(snapshot.data!);
          }
        }
      }
    );
  }
            // return Text(snapshot.data.software, style: Theme.of(context).textTheme.headline1);

  Widget analyticsWidget(Lolminer _minerModel) {
    return Column(
      children: [
        /* Make a col of workers inside an if state @TODO */

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Total Hash Rate:     ${_minerModel.algorithms![0].totalPerformance.toStringAsFixed(3)}Mh/s", style: Theme.of(context).textTheme.headline6),
            Text("Accepted Shares:     ${_minerModel.algorithms![0].totalAccepted}", style: Theme.of(context).textTheme.headline6),
            Text("Rejected Shares:     ${_minerModel.algorithms![0].totalRejected}", style: Theme.of(context).textTheme.headline6),
            Text("Total Stales:     ${_minerModel.algorithms![0].totalStales}", style: Theme.of(context).textTheme.headline6),
          ]
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for(var ijk in _minerModel.workers!) Text("Workers: ${ijk.name}", style: Theme.of(context).textTheme.bodySmall),
            for(var ijk in _minerModel.workers!) Text("Power: ${ijk.power}W", style: Theme.of(context).textTheme.bodySmall),
            for(var ijk in _minerModel.workers!) Text("LHR Unlock: ${ijk.lhrUnlockPct}%", style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for(var ijk in _minerModel.workers!) Text("CCLK: ${ijk.cclk}", style: Theme.of(context).textTheme.bodySmall),
            for(var ijk in _minerModel.workers!) Text("MCLK: ${ijk.mclk}W", style: Theme.of(context).textTheme.bodySmall),
            for(var ijk in _minerModel.workers!) Text("CORE_TEMP: ${ijk.coreTemp}%", style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Software:     ${_minerModel.software}", style: Theme.of(context).textTheme.bodySmall),
            Text("POOL:      ${_minerModel.algorithms![0].pool}s", style: Theme.of(context).textTheme.bodySmall),
            Text("UPTIME:      ${_minerModel.session!.uptime}s", style: Theme.of(context).textTheme.bodySmall),
            Text("# of workers: ${_minerModel.numWorkers}" , style: Theme.of(context).textTheme.bodySmall),
            // Text("Workers:      ${_minerModel.workers}", style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Text("Accepted Shares:     ${_minerModel.algorithms![0].totalAccepted}", style: Theme.of(context).textTheme.headlineSmall),
            // Text("Rejected Shares:     ${_minerModel.algorithms![0].totalRejected}", style: Theme.of(context).textTheme.headlineSmall),
            // Text("Total Hash Rate:     ${_minerModel.algorithms![0].totalPerformance}", style: Theme.of(context).textTheme.headlineSmall),
            Text("Uptime:     ${_minerModel.session!.uptime}", style: Theme.of(context).textTheme.bodySmall),
            Text("Wallet Mining Into:     ${_minerModel.algorithms![0].user}", style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Algorithm:     ${_minerModel.algorithms![0].algorithm}", style: Theme.of(context).textTheme.bodySmall),
            Text("Hash Rate:     ${_minerModel.algorithms![0].workerPerformance}Mh/s", style: Theme.of(context).textTheme.bodySmall),

            Text("STARTUP:      ${_minerModel.session!.startup}", style: Theme.of(context).textTheme.bodySmall),
            Text("last update: ${_minerModel.session!.lastUpdate}" , style: Theme.of(context).textTheme.bodySmall),
            // Text("Workers:      ${_minerModel.workers}", style: Theme.of(context).textTheme.bodySmall)
          ],
        ),



      ],
    );
  } 

  /* @TODO set tto var of type in initState then run a timer and only call var names on type. Set type every time and just run functional code patterns instead of a stream */
  Future<void> _fetchLolMiningData() async {
    var _url =
        Uri.parse('http://127.0.0.1:1339');
    try {
      var response = await http.get(_url);
      print('Response status: ${response.statusCode}');

      final miningData = Lolminer.fromJson(json.decode(response.body));

      print(json.decode(response.body));

      print(miningData);

      _streamCtrl.sink.add(miningData);

      // final parsedTrans = transactionsFromJson(_jsonBody);
      print('#########     ${miningData.session?.uptime}    /   ${miningData.session?.lastUpdate} ####');
      print('#########     ${miningData.software}    /    ${miningData.numWorkers} ##############');
      print('Response status: ${response.statusCode}');

      // return miningData;
    } catch (e) {
      print(e);
    }
  }
}

