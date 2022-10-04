import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:platform137/globals/set_globals.dart' as gbl;

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as rtr;
import 'package:shelf/shelf_io.dart' as io;


void serveAPI() async {
  var app = rtr.Router();

  const String TOP_SECRET_KEY = "top_secret_key<kdkljsdljkdsjklkljsdkjlsdkljsdjklsdjklkjlsdjksdkjlsdkjlklsjdkjlsdljk>";

  // EXAMPLES
  // curl -H "alice: top_secret_key<kdkljsdljkdsjklkljsdkjlsdkljsdjklsdjklkjlsdjksdkjlsdkjlklsjdkjlsdljk>" localhost:8080/api
  // curl -H "alice: top_secret_key<kdkljsdljkdsjklkljsdkjlsdkljsdjklsdjklkjlsdjksdkjlsdkjlklsjdkjlsdljk>" localhost:8080/api/setFans/0/50
  
  void setterFuncs() {
    app.get('/api/id/<id>', (Request request, String _id) {
      final parseID = int.tryParse(_id);

      final jsonData = '{ "fanIndex": "$_id fanIndex", "alice": "$_id in wonderland" }';

      print("\n\n $_id This function will fire from over the wire!");
      return Response.ok(jsonData);
    });

    app.get('/api/setFans/<fanIndex>/<fanVal>', (Request request, String _fanIndex, String _fanVal) {
      var parseID = int.tryParse(_fanIndex);
      final parseFanVal = int.tryParse(_fanVal);

      final reqHeaders = request.headers['alice'];

      print('\n SET FANS HIT\n SET FANS HIT\n SET FANS HIT\n SET FANS HIT');
      if (parseID == null) parseID = 0;
      /* int instead of double */

    
      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        gbl.NvidiaSetFans(parseID, parseFanVal);

        final jsonData = '{ "fanIndex": "$_fanIndex", "fanVal": "$_fanVal" }';

        print("\n\n $_fanIndex is the fanIndex changing fans to  $_fanVal%");
        return Response.ok(jsonData);
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

    app.get('/api/setGraphicsClock/<gpuIndex>/<gpuVal>', (Request request, String _gpuIndex, String _gpuVal) {
      var parseID = int.tryParse(_gpuIndex);
      final parseGPUVal = int.tryParse(_gpuVal);

      final reqHeaders = request.headers['alice'];
      if (parseID == null) parseID = 0;
      /* int instead of double */
    
      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        gbl.NvidiaSetGraphicsClock(parseID, parseGPUVal);

        final jsonData = '{ "gpuIndex": "$_gpuIndex", "gpuVal": "$_gpuVal" }';

        print("\n\n $_gpuIndex is the gpuIndex changing clock val to  $_gpuVal%");
        return Response.ok(jsonData);
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

    app.get('/api/setMemoryClock/<gpuIndex>/<gpuVal>', (Request request, String _gpuIndex, String _gpuVal) {
      var parseID = int.tryParse(_gpuIndex);
      final parseGPUVal = int.tryParse(_gpuVal);

      final reqHeaders = request.headers['alice'];
      if (parseID == null) parseID = 0;
      /* int instead of double */
    
      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        gbl.NvidiaSetMemoryClock(parseID, parseGPUVal);

        final jsonData = '{ "gpuIndex": "$_gpuIndex", "gpuVal": "$_gpuVal" }';

        print("\n\n $_gpuIndex is the gpuIndex changing mem clock val to  $_gpuVal%");
        return Response.ok(jsonData);
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

    app.get('/api/setTempThresh/<gpuIndex>/<gpuVal>', (Request request, String _gpuIndex, String _gpuVal) {
      var parseID = int.tryParse(_gpuIndex);
      final parseGPUVal = int.tryParse(_gpuVal);

      final reqHeaders = request.headers['alice'];
      if (parseID == null) parseID = 0;
      /* int instead of double */
    
      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        gbl.NvidiaSetTempThreshold(parseID, parseGPUVal);

        final jsonData = '{ "gpuIndex": "$_gpuIndex", "gpuVal": "$_gpuVal" }';

        print("\n\n $_gpuIndex is the gpuIndex changing temp thresh val to  $_gpuVal%");
        return Response.ok(jsonData);
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

    app.get('/api/setPowerDraw/<gpuIndex>/<gpuVal>', (Request request, String _gpuIndex, String _gpuVal) {
      var parseID = int.tryParse(_gpuIndex);
      final parseGPUVal = double.tryParse(_gpuVal);

      final reqHeaders = request.headers['alice'];
      if (parseID == null) parseID = 0;
      /* int instead of double */
    
      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        gbl.NvidiaSetPowerDraw(parseID, parseGPUVal);

        final jsonData = '{ "gpuIndex": "$_gpuIndex", "gpuVal": "$_gpuVal" }';

        print("\n\n $_gpuIndex is the gpuIndex changing power draw val to  $_gpuVal%");
        return Response.ok(jsonData);
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

  }

  void getterFuncs() {
    app.get('/api', (Request request) {
      var response = {
        'message': 'API is alive',
        'api_routes': ['/api', '/api/id/<id>', '/api/setFans/<fanIndex>/<fanVal>'
        ]
      };

      final reqHeaders = request.headers['alice'];

      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        print("\n\n This function will fire from over the wire!");
        return Response.ok(jsonEncode(response));
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });
  }



  getterFuncs();  
  setterFuncs();
  var server = await io.serve(app, '192.168.0.8', 8080);
}