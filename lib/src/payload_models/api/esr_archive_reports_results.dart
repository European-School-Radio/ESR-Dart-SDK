import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRArchiveReportsAddResult {
  String status = "";
  String message = "";
  ESRArchiveReport? archiveReport;

  ESRArchiveReportsAddResult({
    required this.status,
    required this.message,
    required this.archiveReport
  });

  factory ESRArchiveReportsAddResult.fromJson(Map<String, dynamic> json){
    return ESRArchiveReportsAddResult(
      status: json['status'],
      message: json['message'],
      archiveReport: ESRArchiveReport.fromJson(json['archive_report'])
    );
  }
}