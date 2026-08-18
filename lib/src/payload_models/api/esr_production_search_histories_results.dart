import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRProductionSearchHistoriesByUserResults {
  String status = "";
  List<ESRProductionSearchHistory> searchTerms = [];

  ESRProductionSearchHistoriesByUserResults({
    required this.status,
    required this.searchTerms
  });

  factory ESRProductionSearchHistoriesByUserResults.fromJson(Map<String, dynamic> json){
    List<ESRProductionSearchHistory> serializedSearchTerms = [];

    List<dynamic> searchTermsList = json['search_terms'] as List<dynamic>;

    serializedSearchTerms = searchTermsList
        .map((singleSearchTerm) => ESRProductionSearchHistory.fromJson(singleSearchTerm as Map<String, dynamic>))
        .toList();

    return ESRProductionSearchHistoriesByUserResults(
      status: json['status'],
      searchTerms: serializedSearchTerms
    );
  }
}