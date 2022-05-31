
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:platform137/models/lolminer.model.dart';

class MiddleSection extends StatefulWidget {
  const MiddleSection({Key? key}) : super(key: key);

  @override
  State<MiddleSection> createState() => _MiddleSectionState();
}


class _MiddleSectionState extends State<MiddleSection> {
  /* @TODO TURN INTO STATEFUL WIDGET */  
  final walletAddr = '';
  final poolUsing = '';


  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 5), (){
    //   Timer mytimer = Timer.periodic(const Duration(seconds: 5), (timer) {
    //     _fetchLolMiningData();
      
    //   });
    // });
    Timer mytimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        _fetchLolMiningData();
      
    });

    return Center(
      child: Text(
        'mining here',
        style: Theme.of(context).textTheme.headline1
      )
    );
  }
}

Future<void> _fetchLolMiningData() async {
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

    // return _finalTrans;

    //  return _addrsList;
  } catch (e) {
    print(e);
  }
}