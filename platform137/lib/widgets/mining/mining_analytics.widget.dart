import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:platform137/models/lolminer.model.dart';

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

  Timer mytimer = Timer.periodic(const Duration(seconds: 5), (timer) {
    _fetchLolMiningData();
  });

  @override
  void dispose() {
    _streamCtrl.close();
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Lolminer>(
      stream: _streamCtrl.stream,
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.waiting: return Center(child: CircularProgressIndicator());
          default: if(snapshot.hasError){
            return Text('Waiting for mining server...', style: Theme.of(context).textTheme.headline1);
          } else {
            return analyticsWidget(snapshot.data!)
          }
        }
      }
    );
  }
            // return Text(snapshot.data.software, style: Theme.of(context).textTheme.headline1);

  Widget analyticsWidget(Lolminer _minerModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text( , style: Theme.of(context).textTheme.bodySmall),
        Text( , style: Theme.of(context).textTheme.bodySmall),
        Text( , style: Theme.of(context).textTheme.bodySmall)
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

