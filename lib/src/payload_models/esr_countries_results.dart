import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRCountriesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRCountry> results = [];

  ESRCountriesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRCountriesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRCountry> serializedCountries = [];

    List<dynamic> countriesList = (json['countries'] ?? json['results']) as List<dynamic>;

    serializedCountries = countriesList
        .map((singleCountry) => ESRCountry.fromJson(singleCountry as Map<String, dynamic>))
        .toList();

    return ESRCountriesPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedCountries.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedCountries
    );
  }
}