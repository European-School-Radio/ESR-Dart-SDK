import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRArchiveSubjectsAddResult {
  String status;
  String message;
  ESRArchiveSubject archiveSubject;

  ESRArchiveSubjectsAddResult({
    required this.status,
    required this.message,
    required this.archiveSubject
  });
  
  factory ESRArchiveSubjectsAddResult.fromJson(Map<String, dynamic> json){
    return ESRArchiveSubjectsAddResult(
      status: json["status"],
      message: json["message"],
      archiveSubject: ESRArchiveSubject.fromJson(json["archive_subject"])
    );
  }
}