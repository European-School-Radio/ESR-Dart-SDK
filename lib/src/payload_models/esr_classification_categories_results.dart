import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRClassificationCategoriesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRClassificationCategory> results = [];

  ESRClassificationCategoriesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRClassificationCategoriesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRClassificationCategory> serializedClassificationCategories = [];

    List<dynamic> classificationCategoriesList = (json['classification_categories'] ?? json['results']) as List<dynamic>;

    serializedClassificationCategories = classificationCategoriesList
        .map((singleClassificationCategory) => ESRClassificationCategory.fromJson(singleClassificationCategory as Map<String, dynamic>))
        .toList();

    return ESRClassificationCategoriesPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedClassificationCategories.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedClassificationCategories
    );
  }
}

class ESRClassificationCategoriesCountryAverageResults {
  String status = "";
  List<ESRClassificationCategory> classificationCategories = [];

  ESRClassificationCategoriesCountryAverageResults({
    required this.status,
    required this.classificationCategories
  });

  factory ESRClassificationCategoriesCountryAverageResults.fromJson(Map<String, dynamic> json){
    return ESRClassificationCategoriesCountryAverageResults(
      status: json['status'],
      classificationCategories: json['classification_categories']
    );
  }
}