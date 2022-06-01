// To parse this JSON data, do
//
//     final lolminer = lolminerFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Lolminer lolminerFromJson(String str) => Lolminer.fromJson(json.decode(str));

String lolminerToJson(Lolminer data) => json.encode(data.toJson());

class Lolminer {
    Lolminer({
        required this.software,
        required this.session,
        required this.numWorkers,
        this.workers,
        this.numAlgorithms,
        this.algorithms,
    });

    final String software;
    final Session? session;
    final int numWorkers;
    final List<Worker>? workers;
    final int? numAlgorithms;
    final List<Algorithm>? algorithms;

    factory Lolminer.fromJson(Map<String, dynamic> json) => Lolminer(
        software: json["Software"],
        session: json["Session"] == null ? null : Session.fromJson(json["Session"]),
        numWorkers: json["Num_Workers"],
        workers: json["Workers"] == null ? null : List<Worker>.from(json["Workers"].map((x) => Worker.fromJson(x))),
        numAlgorithms: json["Num_Algorithms"] == null ? null : json["Num_Algorithms"],
        algorithms: json["Algorithms"] == null ? null : List<Algorithm>.from(json["Algorithms"].map((x) => Algorithm.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Software": software,
        "Session": session == null ? null : session!.toJson(),
        "Num_Workers": numWorkers,
        "Workers": workers == null ? null : List<dynamic>.from(workers!.map((x) => x.toJson())),
        // "Num_Algorithms": numAlgorithms == null ? null : numAlgorithms,
        // "Algorithms": algorithms == null ? null : List<dynamic>.from(algorithms!.map((x) => x.toJson())),
    };
}

class Algorithm {
    Algorithm({
        required this.algorithm,
        required this.algorithmAppendix,
        required this.pool,
        required this.user,
        required this.worker,
        required this.performanceUnit,
        required this.performanceFactor,
        required this.totalPerformance,
        required this.totalAccepted,
        required this.totalRejected,
        required this.totalStales,
        required this.totalErrors,
        required this.workerPerformance,
        required this.workerAccepted,
        required this.workerRejected,
        required this.workerStales,
        required this.workerErrors,
    });

    final String algorithm;
    final String algorithmAppendix;
    final String pool;
    final String user;
    final String worker;
    final String performanceUnit;
    final int performanceFactor;
    final double totalPerformance;
    final int totalAccepted;
    final int totalRejected;
    final int totalStales;
    final int totalErrors;
    final List<double>? workerPerformance;
    final List<int>? workerAccepted;
    final List<int>? workerRejected;
    final List<int>? workerStales;
    final List<int>? workerErrors;

    factory Algorithm.fromJson(Map<String, dynamic> json) => Algorithm(
        algorithm: json["Algorithm"] == null ? null : json["Algorithm"],
        algorithmAppendix: json["Algorithm_Appendix"] == null ? null : json["Algorithm_Appendix"],
        pool: json["Pool"] == null ? null : json["Pool"],
        user: json["User"] == null ? null : json["User"],
        worker: json["Worker"] == null ? null : json["Worker"],
        performanceUnit: json["Performance_Unit"] == null ? null : json["Performance_Unit"],
        performanceFactor: json["Performance_Factor"] == null ? null : json["Performance_Factor"],
        totalPerformance: json["Total_Performance"] == null ? null : json["Total_Performance"].toDouble(),
        totalAccepted: json["Total_Accepted"] == null ? null : json["Total_Accepted"],
        totalRejected: json["Total_Rejected"] == null ? null : json["Total_Rejected"],
        totalStales: json["Total_Stales"] == null ? null : json["Total_Stales"],
        totalErrors: json["Total_Errors"] == null ? null : json["Total_Errors"],
        workerPerformance: json["Worker_Performance"] == null ? null : List<double>.from(json["Worker_Performance"].map((x) => x.toDouble())),
        workerAccepted: json["Worker_Accepted"] == null ? null : List<int>.from(json["Worker_Accepted"].map((x) => x)),
        workerRejected: json["Worker_Rejected"] == null ? null : List<int>.from(json["Worker_Rejected"].map((x) => x)),
        workerStales: json["Worker_Stales"] == null ? null : List<int>.from(json["Worker_Stales"].map((x) => x)),
        workerErrors: json["Worker_Errors"] == null ? null : List<int>.from(json["Worker_Errors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Algorithm": algorithm == null ? null : algorithm,
        "Algorithm_Appendix": algorithmAppendix == null ? null : algorithmAppendix,
        "Pool": pool == null ? null : pool,
        "User": user == null ? null : user,
        "Worker": worker == null ? null : worker,
        "Performance_Unit": performanceUnit == null ? null : performanceUnit,
        "Performance_Factor": performanceFactor == null ? null : performanceFactor,
        "Total_Performance": totalPerformance == null ? null : totalPerformance,
        "Total_Accepted": totalAccepted == null ? null : totalAccepted,
        "Total_Rejected": totalRejected == null ? null : totalRejected,
        "Total_Stales": totalStales == null ? null : totalStales,
        "Total_Errors": totalErrors == null ? null : totalErrors,
        "Worker_Performance": workerPerformance == null ? null : List<dynamic>.from(workerPerformance!.map((x) => x)),
        "Worker_Accepted": workerAccepted == null ? null : List<dynamic>.from(workerAccepted!.map((x) => x)),
        "Worker_Rejected": workerRejected == null ? null : List<dynamic>.from(workerRejected!.map((x) => x)),
        "Worker_Stales": workerStales == null ? null : List<dynamic>.from(workerStales!.map((x) => x)),
        "Worker_Errors": workerErrors == null ? null : List<dynamic>.from(workerErrors!.map((x) => x)),
    };
}

class Session {
    Session({
        required this.startup,
        required this.startupString,
        required this.uptime,
        required this.lastUpdate,
    });

    final int startup;
    final String startupString;
    final int uptime;
    final int lastUpdate;

    factory Session.fromJson(Map<String, dynamic> json) => Session(
        startup: json["Startup"] == null ? null : json["Startup"],
        startupString: json["Startup_String"] == null ? null : json["Startup_String"],
        uptime: json["Uptime"] == null ? null : json["Uptime"],
        lastUpdate: json["Last_Update"] == null ? null : json["Last_Update"],
    );

    Map<String, dynamic> toJson() => {
        "Startup": startup == null ? null : startup,
        "Startup_String": startupString == null ? null : startupString,
        "Uptime": uptime == null ? null : uptime,
        "Last_Update": lastUpdate == null ? null : lastUpdate,
    };
}

class Worker {
    Worker({
        this.index,
        this.name,
        this.power,
        this.cclk,
        this.mclk,
        this.coreTemp,
        this.jucTemp,
        this.memTemp,
        this.fanSpeed,
        this.lhrUnlockPct,
        this.dualFactor,
        this.pcieAddress,
    });

    final int? index;
    final String? name;
    final double? power;
    final int? cclk;
    final int? mclk;
    final int? coreTemp;
    final int? jucTemp;
    final int? memTemp;
    final int? fanSpeed;
    final int? lhrUnlockPct;
    final int? dualFactor;
    final String? pcieAddress;

    factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        index: json["Index"] == null ? null : json["Index"],
        name: json["Name"] == null ? null : json["Name"],
        power: json["Power"] == null ? null : json["Power"].toDouble(),
        cclk: json["CCLK"] == null ? null : json["CCLK"],
        mclk: json["MCLK"] == null ? null : json["MCLK"],
        coreTemp: json["Core_Temp"] == null ? null : json["Core_Temp"],
        jucTemp: json["Juc_Temp"] == null ? null : json["Juc_Temp"],
        memTemp: json["Mem_Temp"] == null ? null : json["Mem_Temp"],
        fanSpeed: json["Fan_Speed"] == null ? null : json["Fan_Speed"],
        lhrUnlockPct: json["LHR_Unlock_Pct"] == null ? null : json["LHR_Unlock_Pct"],
        dualFactor: json["Dual_Factor"] == null ? null : json["Dual_Factor"],
        pcieAddress: json["PCIE_Address"] == null ? null : json["PCIE_Address"],
    );

    Map<String, dynamic> toJson() => {
        "Index": index == null ? null : index,
        "Name": name == null ? null : name,
        "Power": power == null ? null : power,
        "CCLK": cclk == null ? null : cclk,
        "MCLK": mclk == null ? null : mclk,
        "Core_Temp": coreTemp == null ? null : coreTemp,
        "Juc_Temp": jucTemp == null ? null : jucTemp,
        "Mem_Temp": memTemp == null ? null : memTemp,
        "Fan_Speed": fanSpeed == null ? null : fanSpeed,
        "LHR_Unlock_Pct": lhrUnlockPct == null ? null : lhrUnlockPct,
        "Dual_Factor": dualFactor == null ? null : dualFactor,
        "PCIE_Address": pcieAddress == null ? null : pcieAddress,
    };
}
