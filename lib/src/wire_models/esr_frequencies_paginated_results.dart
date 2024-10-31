import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRFrequenciesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRFrequency> results = [];

  ESRFrequenciesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRFrequenciesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRFrequency> serializedFrequencies = [];

    List<dynamic> frequenciesList;
    if (limit == null || limit != -1) {
      frequenciesList = json['results'] as List<dynamic>;
    } else {
      frequenciesList = json['frequencies'] as List<dynamic>;
    }

    serializedFrequencies = frequenciesList
        .map((singleFrequency) => ESRFrequency.fromJson(singleFrequency as Map<String, dynamic>))
        .toList();

    return ESRFrequenciesPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedFrequencies.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedFrequencies
    );
  }
}