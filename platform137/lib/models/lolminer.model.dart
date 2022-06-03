// To parse this JSON data, do
//
//     final lolminer = lolminerFromJson(jsonString);

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
        numAlgorithms: json["Num_Algorithms"],
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
        algorithm: json["Algorithm"],
        algorithmAppendix: json["Algorithm_Appendix"],
        pool: json["Pool"],
        user: json["User"],
        worker: json["Worker"],
        performanceUnit: json["Performance_Unit"],
        performanceFactor: json["Performance_Factor"],
        totalPerformance: json["Total_Performance"] == null ? null : json["Total_Performance"].toDouble(),
        totalAccepted: json["Total_Accepted"],
        totalRejected: json["Total_Rejected"],
        totalStales: json["Total_Stales"],
        totalErrors: json["Total_Errors"],
        workerPerformance: json["Worker_Performance"] == null ? null : List<double>.from(json["Worker_Performance"].map((x) => x.toDouble())),
        workerAccepted: json["Worker_Accepted"] == null ? null : List<int>.from(json["Worker_Accepted"].map((x) => x)),
        workerRejected: json["Worker_Rejected"] == null ? null : List<int>.from(json["Worker_Rejected"].map((x) => x)),
        workerStales: json["Worker_Stales"] == null ? null : List<int>.from(json["Worker_Stales"].map((x) => x)),
        workerErrors: json["Worker_Errors"] == null ? null : List<int>.from(json["Worker_Errors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "Algorithm": algorithm,
        "Algorithm_Appendix": algorithmAppendix,
        "Pool": pool,
        "User": user,
        "Worker": worker,
        "Performance_Unit": performanceUnit,
        "Performance_Factor": performanceFactor,
        "Total_Performance": totalPerformance,
        "Total_Accepted": totalAccepted,
        "Total_Rejected": totalRejected,
        "Total_Stales": totalStales,
        "Total_Errors": totalErrors,
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
        startup: json["Startup"],
        startupString: json["Startup_String"],
        uptime: json["Uptime"],
        lastUpdate: json["Last_Update"],
    );

    Map<String, dynamic> toJson() => {
        "Startup": startup,
        "Startup_String": startupString,
        "Uptime": uptime,
        "Last_Update": lastUpdate,
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
        index: json["Index"],
        name: json["Name"],
        power: json["Power"] == null ? null : json["Power"].toDouble(),
        cclk: json["CCLK"],
        mclk: json["MCLK"],
        coreTemp: json["Core_Temp"],
        jucTemp: json["Juc_Temp"],
        memTemp: json["Mem_Temp"],
        fanSpeed: json["Fan_Speed"],
        lhrUnlockPct: json["LHR_Unlock_Pct"],
        dualFactor: json["Dual_Factor"],
        pcieAddress: json["PCIE_Address"],
    );

    Map<String, dynamic> toJson() => {
        "Index": index,
        "Name": name,
        "Power": power,
        "CCLK": cclk,
        "MCLK": mclk,
        "Core_Temp": coreTemp,
        "Juc_Temp": jucTemp,
        "Mem_Temp": memTemp,
        "Fan_Speed": fanSpeed,
        "LHR_Unlock_Pct": lhrUnlockPct,
        "Dual_Factor": dualFactor,
        "PCIE_Address": pcieAddress,
    };
}
