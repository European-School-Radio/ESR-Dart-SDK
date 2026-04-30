import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRArchiveHistoryListen {
  int id;
  ESRArchive archive;
  ESRUser? user;
  int totalTime;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRArchiveHistoryListen({
    required this.id,
    required this.archive,
    this.user,
    required this.totalTime,
    required this.created,
    required this.updated
  });

  factory ESRArchiveHistoryListen.fromJson(Map<String, dynamic> json){
    return ESRArchiveHistoryListen(
      id: json['id'],
      archive: ESRArchive.fromJson(json['archive']),
      user: (json['user'] == null) ? null : ESRUser.fromJson(json['user']),
      totalTime: json['total_time'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }
}

class ESRAddArchiveHistoryListen {
  int archiveID;
  int totalTime;

  ESRAddArchiveHistoryListen({
    required this.archiveID,
    required this.totalTime
  });
}