import 'dart:convert';
import 'package:esr_dart_sdk/esr_dart_sdk.dart';

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
          .toList() : []
    );
  }
}
