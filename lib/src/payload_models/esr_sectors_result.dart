import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSectorsPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRSector> results = [];

  ESRSectorsPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRSectorsPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRSector> serializedSectors = [];

    List<dynamic> sectorsList = (json['sectors'] ?? json["results"]) as List<dynamic>;

    serializedSectors = sectorsList
        .map((singleSector) => ESRSector.fromJson(singleSector as Map<String, dynamic>))
        .toList();

    return ESRSectorsPaginatedResults(
      count: (limit == null || limit != -1) ? json['count'] : serializedSectors.length,
      nextPage: (limit == null || limit !=- 1) ? json['next'] : null,
      previousPage: (limit == null || limit !=- 1) ? json['previous'] : null,
      results: serializedSectors
    );
  }
}