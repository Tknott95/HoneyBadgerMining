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
  final ScrollController _scrollCtl = ScrollController();

  Timer mytimer = Timer.periodic(const Duration(seconds: 5), (timer) {
    _fetchLolMiningData();
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _fetchLolMiningData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
                child: const Center(
                    // child: LinearProgressIndicator(
                    //   backgroundColor: Colors.black,
                    //   color: Colors.blueGrey,
                    // ),
                    child: Text('L O A D I N G') //CircularProgressIndicator(
                    // backgroundColor: Colors.black,
                    //color: Colors.blueGrey,
                    //),
                    ));
          } else
            return Text(snapshot.data.software, style: Theme.of(context).textTheme.headline1);
        });
  }
}



Stream<Lolminer> _fetchLolMiningData() async* {
  var _url =
      Uri.parse('http://127.0.0.1:1339');
  try {
    var response = await http.get(_url);
    print('Response status: ${response.statusCode}');

    // Map<String, dynamic> _jsonBody = json.decode(response.body);
    // final _jsonBody = json.decode(response.body);
    //.cast<Map<String, dynamic>>();
    // List<dynamic> _addrsList = Addrs.fromJson(_jsonBody);
    // List<Transactions> _transactList = [];

    final miningData = Lolminer.fromJson(json.decode(response.body));

    print(miningData);

    // ${_jsonBody[0]['id']}
    // final _newResp = Transactions.fromJson(_jsonBody);
    // print(
    //     '#######################     ${_newResp}    ################################');

    // final parsedTrans = transactionsFromJson(_jsonBody);
    print(
        '#######################     ${miningData.session?.uptime}    /   ${miningData.session?.lastUpdate} ################################');
    print(
        '#######################     ${miningData.software}    /    ${miningData.numWorkers} ################################');


    print('Response status: ${response.statusCode}');

    yield miningData;
  } catch (e) {
    print(e);
  }
}