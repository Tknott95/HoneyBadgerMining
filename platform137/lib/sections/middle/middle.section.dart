
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:platform137/models/lolminer.model.dart';

class MiddleSection extends StatelessWidget {
  const MiddleSection({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    _fetchLolMiningData();

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

    List _jsonBody = json.decode(response.body);
    // final _jsonBody = json.decode(response.body);
    //.cast<Map<String, dynamic>>();
    // List<dynamic> _addrsList = Addrs.fromJson(_jsonBody);
    // List<Transactions> _transactList = [];
    List<Lolminer> _finalTrans = _jsonBody
        .map<Lolminer>((ijk) => Lolminer.fromJson(ijk))
        .toList();
    // ${_jsonBody[0]['id']}
    // final _newResp = Transactions.fromJson(_jsonBody);
    // print(
    //     '#######################     ${_newResp}    ################################');

    // final parsedTrans = transactionsFromJson(_jsonBody);
    print(
        '#######################     ${_finalTrans[0].numWorkers}    /    ${_finalTrans[0].algorithms} ################################');
    print(
        '#######################     ${_finalTrans[0].software}    /    ${_finalTrans[0].workers} ################################');

    print('Amount of transactions:  ${_finalTrans.length}');

    print('Response status: ${response.statusCode}');

    // return _finalTrans;

    //  return _addrsList;
  } catch (e) {
    print(e);
  }
}