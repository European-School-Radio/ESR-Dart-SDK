import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRZonesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRZone> results = [];

  ESRZonesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRZonesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRZone> serializedZones = [];

    List<dynamic> zonesList;
    if (limit == null || limit != -1) {
      zonesList = json['results'] as List<dynamic>;
    } else {
      zonesList = json['zones'] as List<dynamic>;
    }

    serializedZones = zonesList
        .map((singleZone) => ESRZone.fromJson(singleZone as Map<String, dynamic>))
        .toList();

    return ESRZonesPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedZones.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedZones
    );
  }
}