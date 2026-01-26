import 'dart:convert';

import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRProductionsAddResults {
  String status;
  String message;
  ESRProduction production;

  ESRProductionsAddResults({
    required this.status,
    required this.message,
    required this.production
  });

  factory ESRProductionsAddResults.fromJson(Map<String, dynamic> json){
    return ESRProductionsAddResults(
        status: json["status"],
        message: json["message"],
        production: ESRProduction.fromJson(json["production"])
    );
  }
}

class ESRProductionsPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRProduction> results = [];

  ESRProductionsPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRProductionsPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRProduction> serializedProductions = [];

    List<dynamic> productionsList = (json['productions'] ?? json['results']) as List<dynamic>;

    serializedProductions = productionsList
        .map((singleProduction) => ESRProduction.fromJson(singleProduction as Map<String, dynamic>))
        .where((item) => !item.disabled)
        .toList();

    return ESRProductionsPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedProductions.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedProductions
    );
  }
}

class ESRProductionsWebsocketListResults {
  int count = 0;
  List<ESRProduction> results = [];

  ESRProductionsWebsocketListResults({
    required this.count,
    required this.results
  });

  factory ESRProductionsWebsocketListResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRProduction> serializedProductions = [];

    if (!json.containsKey("data") || json['data'] == null){
      return ESRProductionsWebsocketListResults(
          count: 0,
          results: []
      );
    }

    List<dynamic> productionsList = json['data'] as List<dynamic>;

    serializedProductions = productionsList
        .map((singleProduction) => ESRProduction.fromJson(singleProduction as Map<String, dynamic>))
        .where((item) => !item.disabled)
        .toList();

    return ESRProductionsWebsocketListResults(
        count: json['count'] ?? 0,
        results: serializedProductions
    );
  }
}

class ESRProductionsPopularPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRProduction> results = [];

  ESRProductionsPopularPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRProductionsPopularPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRProduction> serializedProductions = [];

    List<dynamic> productionsList = (json['popular_productions'] ?? json['results']) as List<dynamic>;

    serializedProductions = productionsList
        .map((singleProduction) => ESRProduction.fromJson(singleProduction as Map<String, dynamic>))
        .where((item) => !item.disabled)
        .toList();

    return ESRProductionsPopularPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedProductions.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedProductions
    );
  }
}

class ESRProductionsNowPlayingResults {
  String message = "";
  bool hasNowPlayingProduction = false;
  List<DateTime> broadcastDays = [];
  List<DateTime> broadcastTimeStarts = [];
  List<DateTime> broadcastTimeEnds = [];
  List<ESRProduction> nowPlayingProductions = [];

  ESRProductionsNowPlayingResults(
      {required this.message,
        required this.hasNowPlayingProduction,
        required this.broadcastDays,
        required this.broadcastTimeStarts,
        required this.broadcastTimeEnds,
        required this.nowPlayingProductions});

  factory ESRProductionsNowPlayingResults.fromJson(Map<String, dynamic> response) {
    final Map<String, dynamic> nowPlayingProductionsParsed = json.decode(response["data"]);

    return ESRProductionsNowPlayingResults(
        message: response["message"],
        hasNowPlayingProduction: nowPlayingProductionsParsed["has_now_playing_production"],
        broadcastDays: (nowPlayingProductionsParsed['found_broadcast_days'] as List)
            .map((dateStr) => DateTime.parse("$dateStr 00:00:00Z").toLocal())
            .toList(),
        broadcastTimeStarts: (nowPlayingProductionsParsed['found_time_start'] as List)
            .map((dateStr) => DateTime.parse("1970-01-01 ${dateStr}Z").toLocal())
            .toList(),
        broadcastTimeEnds: (nowPlayingProductionsParsed['found_time_end'] as List)
            .map((dateStr) => DateTime.parse("1970-01-01 ${dateStr}Z").toLocal())
            .toList(),
        nowPlayingProductions: (nowPlayingProductionsParsed.containsKey("now_playing_production_details") && nowPlayingProductionsParsed['now_playing_production_details'] != null) ? (nowPlayingProductionsParsed['now_playing_production_details'] as List)
            .map((prod) => ESRProduction.fromJson(prod))
            .where((item) => !item.disabled)
            .toList() : []
    );
  }
}

class ESRProductionsNextPlayingResults {
  String message = "";
  int maxItems = 0;
  bool hasNextPlayingProduction = false;
  List<DateTime> broadcastDays = [];
  List<DateTime> broadcastTimeStarts = [];
  List<DateTime> broadcastTimeEnds = [];
  List<ESRProduction> nextPlayingProductions = [];
  DateTime todayDate = DateTime.now();

  ESRProductionsNextPlayingResults(
      {required this.message,
        required this.maxItems,
        required this.hasNextPlayingProduction,
        required this.broadcastDays,
        required this.broadcastTimeStarts,
        required this.broadcastTimeEnds,
        required this.nextPlayingProductions,
        required this.todayDate});

  factory ESRProductionsNextPlayingResults.fromJson(Map<String, dynamic> response) {
    final Map<String, dynamic> nextPlayingProductionsParsed = json.decode(response["data"]);

    return ESRProductionsNextPlayingResults(
        message: response["message"],
        maxItems: response["max_item"],
        hasNextPlayingProduction: nextPlayingProductionsParsed["has_next_playing_production"],
        broadcastDays: (nextPlayingProductionsParsed['found_broadcast_days'] as List)
            .map((dateStr) => DateTime.parse("$dateStr 00:00:00Z").toLocal())
            .toList(),
        broadcastTimeStarts: (nextPlayingProductionsParsed['found_time_start'] as List)
            .map((dateStr) => DateTime.parse("1970-01-01 ${dateStr}Z").toLocal())
            .toList(),
        broadcastTimeEnds: (nextPlayingProductionsParsed['found_time_end'] as List)
            .map((dateStr) => DateTime.parse("1970-01-01 ${dateStr}Z").toLocal())
            .toList(),
        nextPlayingProductions: (nextPlayingProductionsParsed['next_playing_production_details'] as List)
            .map((prod) => ESRProduction.fromJson(prod))
            .where((item) => !item.disabled)
            .toList(),
        todayDate: DateTime.parse(nextPlayingProductionsParsed["today_date"] + " 00:00:00")
    );
  }
}

class ESRProductionsIncreaseSharesCounterResults {
  String status = "";
  String message = "";

  ESRProductionsIncreaseSharesCounterResults({
    required this.status,
    required this.message
  });

  factory ESRProductionsIncreaseSharesCounterResults.fromJson(Map<String, dynamic> json){
    return ESRProductionsIncreaseSharesCounterResults(
      status: json['status'],
      message: json['message']
    );
  }
}

class ESRProductionsSharesCounterByProductionResults {
  int count = 0;

  ESRProductionsSharesCounterByProductionResults({
    required this.count
  });

  factory ESRProductionsSharesCounterByProductionResults.fromJson(Map<String, dynamic> json){
    return ESRProductionsSharesCounterByProductionResults(
      count: json['count']
    );
  }
}