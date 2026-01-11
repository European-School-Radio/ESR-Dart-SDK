import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRProductionsAddResults {
  String status;
  String message;
  ESRProduction production;

  ESRProductionsAddResults({
    required this.status,
    required this.message,
    required this.production
  });

  factory ESRProductionsAddResults.fromJson(Map<String, dynamic> json){
    return ESRProductionsAddResults(
        status: json["status"],
        message: json["message"],
        production: ESRProduction.fromJson(json["production"])
    );
  }
}

class ESRProductionsPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRProduction> results = [];

  ESRProductionsPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRProductionsPaginatedResults.fromJson(Map<String, dynamic> json, int? limit, { bool isWebSocket = false }){
    List<ESRProduction> serializedProductions = [];
    List<dynamic> productionsList = [];

    if (isWebSocket){
      productionsList = json['data'] as List<dynamic>;
    } else {
      productionsList = (json['productions'] ?? json['results']) as List<dynamic>;
    }

    serializedProductions = productionsList
        .map((singleProduction) => ESRProduction.fromJson(singleProduction as Map<String, dynamic>))
        .where((item) => !item.disabled)
        .toList();

    return ESRProductionsPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedProductions.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedProductions
    );
  }
}

class ESRProductionsPopularPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRProduction> results = [];

  ESRProductionsPopularPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRProductionsPopularPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRProduction> serializedProductions = [];

    List<dynamic> productionsList = (json['popular_productions'] ?? json['results']) as List<dynamic>;

    serializedProductions = productionsList
        .map((singleProduction) => ESRProduction.fromJson(singleProduction as Map<String, dynamic>))
        .where((item) => !item.disabled)
        .toList();

    return ESRProductionsPopularPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedProductions.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedProductions
    );
  }
}