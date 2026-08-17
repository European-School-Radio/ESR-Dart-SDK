import 'package:esr_dart_sdk/esr_dart_sdk.dart';
import 'package:esr_dart_sdk/src/utils/is_numeric.dart';

class ESRArchiveReport {
  int id = 0;
  ESRArchive? archive;
  ESRReportReason? reportReason;
  String description = "";
  ESRUser? user;
  String replyDescription = "";
  ESRUser? updatedBy;
  bool reportClosed = false;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();

  ESRArchiveReport({
    required this.id,
    required this.archive,
    required this.reportReason,
    required this.description,
    required this.user,
    required this.replyDescription,
    required this.updatedBy,
    required this.reportClosed,
    required this.created,
    required this.updated
  });

  factory ESRArchiveReport.fromJson(Map<String, dynamic> json){
    return ESRArchiveReport(
      id: json['id'],
      archive: IsNumericUtils.isNumeric(json['archive'].toString()) ? null : ESRArchive.fromJson(json['archive']),
      reportReason: IsNumericUtils.isNumeric(json['report_reason'].toString()) ? null : ESRReportReason.fromJson(json['report_reason']),
      description: json['description'],
      user: IsNumericUtils.isNumeric(json['user'].toString()) ? null : ESRUser.fromJson(json['user']),
      replyDescription: json['reply_description'],
      updatedBy: (json['updated_by'] == null || IsNumericUtils.isNumeric(json['updated_by'].toString())) ? null : ESRUser.fromJson(json['updated_by']),
      reportClosed: json['report_closed'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated'])
    );
  }
}