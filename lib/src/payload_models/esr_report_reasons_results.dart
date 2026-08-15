import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRReportReasonsPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRReportReason> results = [];

  ESRReportReasonsPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRReportReasonsPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRReportReason> serializedReportReasons = [];

    List<dynamic> reportReasonsList = (json['report_reasons'] ?? json['results']) as List<dynamic>;

    serializedReportReasons = reportReasonsList
        .map((singleReportReason) => ESRReportReason.fromJson(singleReportReason as Map<String, dynamic>))
        .toList();

    return ESRReportReasonsPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedReportReasons.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedReportReasons
    );
  }
}