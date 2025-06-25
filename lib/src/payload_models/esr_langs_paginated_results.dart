import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRLangsPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRLang> results = [];

  ESRLangsPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRLangsPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRLang> serializedLangs = [];

    List<dynamic> langsList;
    if (limit == null || limit != -1) {
      langsList = json['results'] as List<dynamic>;
    } else {
      langsList = json['langs'] as List<dynamic>;
    }

    serializedLangs = langsList
        .map((singleLang) => ESRLang.fromJson(singleLang as Map<String, dynamic>))
        .toList();

    return ESRLangsPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedLangs.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedLangs
    );
  }
}