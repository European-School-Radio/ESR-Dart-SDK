import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRUserSearchHistoriesByUserResults {
  String status = "";
  List<ESRUserSearchHistory> searchTerms = [];

  ESRUserSearchHistoriesByUserResults({
    required this.status,
    required this.searchTerms
  });

  factory ESRUserSearchHistoriesByUserResults.fromJson(Map<String, dynamic> json){
    List<ESRUserSearchHistory> serializedSearchTerms = [];

    List<dynamic> searchTermsList = json['search_terms'] as List<dynamic>;

    serializedSearchTerms = searchTermsList
        .map((singleSearchTerm) => ESRUserSearchHistory.fromJson(singleSearchTerm as Map<String, dynamic>))
        .toList();

    return ESRUserSearchHistoriesByUserResults(
      status: json['status'],
      searchTerms: serializedSearchTerms
    );
  }
}