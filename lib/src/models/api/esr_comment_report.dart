import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRCommentReport {
  int id = 0;
  ESRComment? comment;
  ESRReportReason? reportReason;
  String description = "";
  ESRUser? user;
  String replyDescription = "";
  ESRUser? updatedBy;
  bool reportClosed = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRCommentReport({
    required this.id,
    required this.comment,
    required this.reportReason,
    required this.description,
    required this.user,
    required this.replyDescription,
    required this.updatedBy,
    required this.reportClosed,
    required this.created,
    required this.updated
  });
  
  factory ESRCommentReport.fromJson(Map<String, dynamic> json){
    return ESRCommentReport(
      id: json['id'],
      comment: IsNumericUtils.isNumeric(json['comment'].toString()) ? null : ESRComment.fromJson(json['comment']),
      reportReason: IsNumericUtils.isNumeric(json['report_reason'].toString()) ? null : ESRReportReason.fromJson(json['report_reason']),
      description: json['description'],
      user: IsNumericUtils.isNumeric(json['user'].toString()) ? null : ESRUser.fromJson(json['user']),
      replyDescription: json['reply_description'],
      updatedBy: IsNumericUtils.isNumeric(json['updated_by'].toString()) ? null : ESRUser.fromJson(json['updated_by']),
      reportClosed: json['report_closed'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}