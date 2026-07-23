import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRGendersPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRGender> results = [];

  ESRGendersPaginatedResults({
    required this.count,
    required this.nextPage,
    required this.previousPage,
    required this.results
  });

  factory ESRGendersPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRGender> serializedGenders = [];

    List<dynamic> gendersList = (json['genders'] ?? json['results']) as List<dynamic>;

    serializedGenders = gendersList
        .map((singleGender) => ESRGender.fromJson(singleGender as Map<String, dynamic>))
        .toList();

    return ESRGendersPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedGenders.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedGenders
    );
  }
}