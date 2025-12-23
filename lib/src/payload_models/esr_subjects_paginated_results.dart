import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSubjectsPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRSubject> results = [];

  ESRSubjectsPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRSubjectsPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRSubject> serializedSubjects = [];

    List<dynamic> subjectsList = (json['subjects'] ?? json['results']) as List<dynamic>;

    serializedSubjects = subjectsList
        .map((singleSubject) => ESRSubject.fromJson(singleSubject as Map<String, dynamic>))
        .toList();

    return ESRSubjectsPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedSubjects.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedSubjects
    );
  }
}