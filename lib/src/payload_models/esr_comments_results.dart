import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRCommentsPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRComment> results = [];

  ESRCommentsPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRCommentsPaginatedResults.fromJson(Map<String, dynamic> json){
     List<ESRComment> serializedComments = (json['results'] as List<dynamic>)
        .map((singleComment) => ESRComment.fromJson(singleComment as Map<String, dynamic>))
        .toList();

    return ESRCommentsPaginatedResults(
        count: json['count'],
        nextPage: json['next'],
        previousPage: json['previous'],
        results: serializedComments
    );
  }
}