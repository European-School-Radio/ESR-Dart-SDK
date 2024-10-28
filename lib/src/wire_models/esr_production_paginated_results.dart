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

  factory ESRProductionPaginatedResults.fromJson(Map<String, dynamic> json){
    List<ESRProduction> serializedProductions = (json['results'] as List<dynamic>)
        .map((singleProduction) => ESRProduction.fromJson(singleProduction as Map<String, dynamic>))
        .toList();
    return ESRProductionPaginatedResults(
        count: json['count'],
        nextPage: json['next'],
        previousPage: json['previous'],
        results: serializedProductions
    );
  }
}