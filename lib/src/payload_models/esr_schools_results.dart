import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSchoolsPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRSchool> results = [];

  ESRSchoolsPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRSchoolsPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRSchool> serializedSchools = [];

    List<dynamic> schoolsList = (json['schools'] ?? json['results']) as List<dynamic>;

    serializedSchools = schoolsList
        .map((singleSchool) => ESRSchool.fromJson(singleSchool as Map<String, dynamic>))
        .where((item) => !item.disabled)
        .toList();

    return ESRSchoolsPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedSchools.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedSchools
    );
  }
}