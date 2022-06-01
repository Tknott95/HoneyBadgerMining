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
  StreamController<Lolminer> _streamCtrl = StreamController();


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
                'WAITING FOR MINING TO BEGIN - START MINING ABOVE',
                style: Theme.of(context).textTheme.bodySmall
              ),
               SpinKitDancingSquare(
                size: 100,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Color.fromARGB(255, 179, 179, 179) : Color.fromARGB(255, 220, 220, 219),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Software:     ${_minerModel.software}", style: Theme.of(context).textTheme.bodySmall),
            Text("UPTIME:      ${_minerModel.session!.uptime}s", style: Theme.of(context).textTheme.bodySmall),
            Text("# of workers: ${_minerModel.numWorkers}" , style: Theme.of(context).textTheme.bodySmall),
            // Text("Workers:      ${_minerModel.workers}", style: Theme.of(context).textTheme.bodySmall)
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Algorithm:     ${_minerModel.algorithms![0].algorithm}", style: Theme.of(context).textTheme.bodySmall),
            Text("Accepted Shares:     ${_minerModel.algorithms![0].totalAccepted}", style: Theme.of(context).textTheme.bodySmall),
            Text("Hash Rate:     ${_minerModel.algorithms![0].workerPerformance}", style: Theme.of(context).textTheme.bodySmall),

            Text("STARTUP:      ${_minerModel.session!.startup}", style: Theme.of(context).textTheme.bodySmall),
            Text("last update: ${_minerModel.session!.lastUpdate}" , style: Theme.of(context).textTheme.bodySmall),
            // Text("Workers:      ${_minerModel.workers}", style: Theme.of(context).textTheme.bodySmall)

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             for(var ijk in _minerModel.workers!) Text("Workers: ${ijk.name}", style: Theme.of(context).textTheme.bodySmall),
            for(var ijk in _minerModel.workers!) Text("Power: ${ijk.power}W", style: Theme.of(context).textTheme.bodySmall),

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

      final miningData = new Lolminer.fromJson(json.decode(response.body));

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

