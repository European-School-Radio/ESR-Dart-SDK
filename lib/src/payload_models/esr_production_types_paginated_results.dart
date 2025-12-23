import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRProductionTypesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRProductionType> results = [];

  ESRProductionTypesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRProductionTypesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRProductionType> serializedProductionTypes = [];

    List<dynamic> productionTypesList = (json['production_types'] ?? json['results']) as List<dynamic>;

    serializedProductionTypes = productionTypesList
        .map((singleProductionType) => ESRProductionType.fromJson(singleProductionType as Map<String, dynamic>))
        .toList();

    return ESRProductionTypesPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedProductionTypes.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedProductionTypes
    );
  }
}