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

class ESRArchiveHistoryListensUpdateResults {
  String status = "";
  String message = "";

  ESRArchiveHistoryListensUpdateResults({
    required this.status,
    required this.message
  });

  factory ESRArchiveHistoryListensUpdateResults.fromJson(Map<String, dynamic> json){
    return ESRArchiveHistoryListensUpdateResults(
      status: json['status'],
      message: json['message']
    );
  }
}

class ESRArchiveHistoryListensByUserResults {
  String message = "";
  int count = 0;
  Map<String, List<ESRArchiveHistoryListen>> archiveHistoryListens = {};

  ESRArchiveHistoryListensByUserResults({
    required this.message,
    required this.count,
    required this.archiveHistoryListens
  });

  factory ESRArchiveHistoryListensByUserResults.fromJson(Map<String, dynamic> json){
    Map<String, List<ESRArchiveHistoryListen>> archiveHistoryListens = {};

    Map<String, dynamic> historyListensList = (json['data'] ?? json['results']) as Map<String, dynamic>;

    archiveHistoryListens = historyListensList.map((dateKey, listJson) {
      final historyList = (listJson as List)
          .map((item) => ESRArchiveHistoryListen.fromJson(item as Map<String, dynamic>))
          .toList();

      return MapEntry(dateKey, historyList);
    });

    return ESRArchiveHistoryListensByUserResults(
      message: json['message'],
      count: json['count'],
      archiveHistoryListens: archiveHistoryListens
    );
  }
}