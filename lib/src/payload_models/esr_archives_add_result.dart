import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRArchivesAddResults {
  String status;
  String message;
  ESRArchive archive;

  ESRArchivesAddResults({
    required this.status,
    required this.message,
    required this.archive
  });
  
  factory ESRArchivesAddResults.fromJson(Map<String, dynamic> json){
    return ESRArchivesAddResults(
      status: json["status"],
      message: json["message"],
        archive: ESRArchive.fromJson(json["archive"])
    );
  }
}