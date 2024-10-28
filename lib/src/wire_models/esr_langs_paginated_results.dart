import 'package:esr_dart_sdk/src/models/esr_lang.dart';

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

  factory ESRLangsPaginatedResults.fromJson(Map<String, dynamic> json){
    List<ESRLang> serializedLangs = (json['results'] as List<dynamic>)
        .map((singleLang) => ESRLang.fromJson(singleLang as Map<String, dynamic>))
        .toList();
    return ESRLangsPaginatedResults(
        count: json['count'],
        nextPage: json['next'],
        previousPage: json['previous'],
        results: serializedLangs
    );
  }
}