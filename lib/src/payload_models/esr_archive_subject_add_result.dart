import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRArchiveSubjectAddResult {
  String status;
  String message;
  ESRArchiveSubject archiveSubject;

  ESRArchiveSubjectAddResult({
    required this.status,
    required this.message,
    required this.archiveSubject
  });
  
  factory ESRArchiveSubjectAddResult.fromJson(Map<String, dynamic> json){
    return ESRArchiveSubjectAddResult(
      status: json["status"],
      message: json["message"],
      archiveSubject: ESRArchiveSubject.fromJson(json["archive_subject"])
    );
  }
}