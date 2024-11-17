import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';

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
          .map((dateStr) => DateTime.parse(dateStr).toLocal())
          .toList(),
      broadcastTimeStarts: (nextPlayingProductionsParsed['found_time_start'] as List)
          .map((dateStr) => DateTime.parse(dateStr).toLocal())
          .toList(),
      broadcastTimeEnds: (nextPlayingProductionsParsed['found_time_end'] as List)
          .map((dateStr) => DateTime.parse(dateStr).toLocal())
          .toList(),
      nextPlayingProductions: (nextPlayingProductionsParsed['next_playing_production_details'] as List)
          .map((prod) => ESRProduction.fromJson(prod))
          .toList(),
      todayDate: DateTime.parse(nextPlayingProductionsParsed["today_date"] + " 00:00:00")
    );
  }
}
