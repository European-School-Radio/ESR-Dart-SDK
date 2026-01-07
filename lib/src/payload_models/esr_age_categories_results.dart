import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRAgeCategoriesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRAgeCategory> results = [];

  ESRAgeCategoriesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRAgeCategoriesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRAgeCategory> serializedAgeCategories = [];

    List<dynamic> ageCategoriesList = (json['age_categories'] ?? json['results']) as List<dynamic>;

    serializedAgeCategories = ageCategoriesList
        .map((singleAgeCategory) => ESRAgeCategory.fromJson(singleAgeCategory as Map<String, dynamic>))
        .toList();

    return ESRAgeCategoriesPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedAgeCategories.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedAgeCategories
    );
  }
}