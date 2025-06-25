import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSchoolTypesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRSchoolType> results = [];

  ESRSchoolTypesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRSchoolTypesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRSchoolType> serializedSchoolTypes = [];

    List<dynamic> schoolTypesList;
    if (limit == null || limit != -1) {
      schoolTypesList = json['results'] as List<dynamic>;
    } else {
      schoolTypesList = json['school_types'] as List<dynamic>;
    }

    serializedSchoolTypes = schoolTypesList
        .map((singleSchoolType) => ESRSchoolType.fromJson(singleSchoolType as Map<String, dynamic>))
        .toList();

    return ESRSchoolTypesPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedSchoolTypes.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedSchoolTypes
    );
  }
}