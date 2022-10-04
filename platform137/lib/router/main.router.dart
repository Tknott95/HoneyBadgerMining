import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:platform137/globals/set_globals.dart' as gbl;
import 'package:platform137/globals/get_globals.dart' as gbl;

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart' as rtr;
import 'package:shelf/shelf_io.dart' as io;

/* @TODO - NEED TO CHECK HOW MANY GPUS BEFORE RETURNING. INSTANTIATE CODE ON FLY. */
/* @TODO pass down router then refactor into own files. Refactor the code how it needs to be after MVP. */

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

  void getterFuncs() /*async*/ {
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

    /* curl -H "alice: top_secret_key<kdkljsdljkdsjklkljsdkjlsdkljsdjklsdjklkjlsdjksdkjlsdkjlklsjdkjlsdljk>" 192.168.0.8:8080/api/get/gpuCount  */
    app.get('/api/get/gpuCount', (Request request) async {
      var _gpuCount = await gbl.nvidia_get_gpu_count();

      final jsonData = {"gpuCount":  "$_gpuCount" };

      final reqHeaders = request.headers['alice'];

      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        print("\n\n This function will fire from over the wire!");
        return Response.ok(jsonEncode(jsonData));
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

    /* curl -H "alice: top_secret_key<kdkljsdljkdsjklkljsdkjlsdkljsdjklsdjklkjlsdjksdkjlsdkjlklsjdkjlsdljk>" 192.168.0.8:8080/api/get/fanSpeed  */
    app.get('/api/get/fanSpeed', (Request request) async {
      var _gpuIndex = 0;
      var _gpuVal = 50;

      var fanSpeedGPU00 = await gbl.nvidia_get_fan_speed(0);
      var fanSpeedGPU01 = await gbl.nvidia_get_fan_speed(1);

      final jsonData = {"fans": [ { "gpuIndex0": "00", "gpuVal": "$fanSpeedGPU00" }, { "gpuIndex1": "01", "gpuVal": "$fanSpeedGPU01" } ]};


      final reqHeaders = request.headers['alice'];

      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        print("\n\n This function will fire from over the wire!");
        return Response.ok(jsonEncode(jsonData));
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

    app.get('/api/get/gpuTemp', (Request request) async {
      var _gpuIndex = 0;
      var _gpuVal = 50;

      var _tempGPU00 = await gbl.nvidia_get_gpu_temp(0);
      var _tempGPU01 = await gbl.nvidia_get_gpu_temp(1);

      final jsonData = {"gpuTemp": [ { "gpuIndex0": "00", "gpuVal": "$_tempGPU00" }, { "gpuIndex1": "01", "gpuVal": "$_tempGPU01" } ]};


      final reqHeaders = request.headers['alice'];

      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        print("\n\n This function will fire from over the wire!");
        return Response.ok(jsonEncode(jsonData));
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

    app.get('/api/get/powerDraw', (Request request) async {
      var _tempGPU00 = await gbl.nvidia_get_power_draw(0);
      var _tempGPU01 = await gbl.nvidia_get_power_draw(1);

      final jsonData = {"gpuTemp": [ { "gpuIndex0": "$_tempGPU00" }, { "gpuIndex1": "$_tempGPU01" } ]};


      final reqHeaders = request.headers['alice'];

      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        print("\n\n This function will fire from over the wire!");
        return Response.ok(jsonEncode(jsonData));
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

    app.get('/api/get/memoryClock', (Request request) async {
      var _gpuIndex = 0;

      var _memClockGPU00 = await gbl.nvidia_get_memory_clock(0);
      var _memClockGPU01 = await gbl.nvidia_get_memory_clock(1);

      print(_memClockGPU00);
      print(_memClockGPU01);

      final jsonData = {"memoryClock": [ { "gpuIndex0": "$_memClockGPU00" }, { "gpuIndex1": "$_memClockGPU01" } ]};

      final reqHeaders = request.headers['alice'];

      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        print("\n\n This function will fire from over the wire!");
        return Response.ok(jsonEncode(jsonData));
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

    app.get('/api/get/graphicsClock', (Request request) async {
      /* this will be called by indexVal prob then code instantiated on fly modular */
      var _gpuIndex = 0;

      var _graphClockGPU00 = await gbl.nvidia_get_graphics_clock(0);
      var _graphClockGPU01 = await gbl.nvidia_get_graphics_clock(1);

      final jsonData = {"graphicsClock": [ { "gpuIndex0": "$_graphClockGPU00" }, { "gpuIndex1": "$_graphClockGPU01" } ]};


      final reqHeaders = request.headers['alice'];

      if (reqHeaders == TOP_SECRET_KEY) {
        print("\n HEADERS: $reqHeaders \n");
        print("\n HEADERS: $reqHeaders \n");

        print("\n\n This function will fire from over the wire!");
        return Response.ok(jsonEncode(jsonData));
      } else {
        return Response.forbidden(jsonEncode({'entry': 'DENIED'}));
      }
    });

  }



  getterFuncs();  
  setterFuncs();
  var server = await io.serve(app, '192.168.0.8', 8080);
}