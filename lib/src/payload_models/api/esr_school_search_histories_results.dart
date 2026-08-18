import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRSchoolSearchHistoriesByUserResults {
  String status = "";
  List<ESRSchoolSearchHistory> searchTerms = [];

  ESRSchoolSearchHistoriesByUserResults({
    required this.status,
    required this.searchTerms
  });

  factory ESRSchoolSearchHistoriesByUserResults.fromJson(Map<String, dynamic> json){
    List<ESRSchoolSearchHistory> serializedSearchTerms = [];

    List<dynamic> searchTermsList = json['search_terms'] as List<dynamic>;

    serializedSearchTerms = searchTermsList
        .map((singleSearchTerm) => ESRSchoolSearchHistory.fromJson(singleSearchTerm as Map<String, dynamic>))
        .toList();

    return ESRSchoolSearchHistoriesByUserResults(
      status: json['status'],
      searchTerms: serializedSearchTerms
    );
  }
}