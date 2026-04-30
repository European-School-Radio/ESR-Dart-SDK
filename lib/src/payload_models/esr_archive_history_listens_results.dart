import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRArchiveHistoryListensAddResults {
  String status = "";
  String message = "";
  ESRArchiveHistoryListen archiveHistoryListen;

  ESRArchiveHistoryListensAddResults({
    required this.status,
    required this.message,
    required this.archiveHistoryListen
  });
  
  factory ESRArchiveHistoryListensAddResults.fromJson(Map<String, dynamic> json){
    return ESRArchiveHistoryListensAddResults(
      status: json['status'],
      message: json['message'],
      archiveHistoryListen: ESRArchiveHistoryListen.fromJson(json['archive_history_listen'])
    );
  }
}