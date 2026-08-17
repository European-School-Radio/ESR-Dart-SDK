import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRRatingTypesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRRatingType> results = [];

  ESRRatingTypesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRRatingTypesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRRatingType> serializedRatingTypes = [];

    List<dynamic> ratingTypesList = (json['rating_types'] ?? json['results']) as List<dynamic>;

    serializedRatingTypes = ratingTypesList
        .map((singleRatingType) => ESRRatingType.fromJson(singleRatingType as Map<String, dynamic>))
        .where((item) => !item.disabled)
        .toList();

    return ESRRatingTypesPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedRatingTypes.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedRatingTypes
    );
  }
}