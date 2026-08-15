import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRCommentReportsAddResult {
  String status = "";
  String message = "";
  ESRCommentReport? commentReport;

  ESRCommentReportsAddResult({
    required this.status,
    required this.message,
    required this.commentReport
  });

  factory ESRCommentReportsAddResult.fromJson(Map<String, dynamic> json){
    return ESRCommentReportsAddResult(
      status: json['status'],
      message: json['message'],
      commentReport: ESRCommentReport.fromJson(json['comment_report'])
    );
  }
}