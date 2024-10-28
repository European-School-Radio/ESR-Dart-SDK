import 'package:esr_dart_sdk/src/models/esr_production.dart';

class ESRProductionPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRProduction> results = [];

  ESRProductionPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRProductionPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRProduction> serializedProductions = [];

    List<dynamic> productionsList;
    if (limit == null || limit != -1) {
      productionsList = json['results'] as List<dynamic>;
    } else {
      productionsList = json['productions'] as List<dynamic>;
    }

    serializedProductions = productionsList
        .map((singleProduction) => ESRProduction.fromJson(singleProduction as Map<String, dynamic>))
        .toList();

    return ESRProductionPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedProductions.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedProductions
    );
  }
}