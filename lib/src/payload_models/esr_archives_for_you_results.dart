import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRArchivesForYouResults {
  String status = "";
  bool resultsAreSuggestions = true;
  List<ESRArchive> suggestedArchives = [];

  ESRArchivesForYouResults({
    required this.status,
    required this.resultsAreSuggestions,
    required this.suggestedArchives
  });

  factory ESRArchivesForYouResults.fromJson(Map<String, dynamic> json){
    List<ESRArchive> serializedArchives = [];

    List<dynamic> archivesList = json['suggested_archives'] as List<dynamic>;

    serializedArchives = archivesList
        .map((singleArchive) => ESRArchive.fromJson(singleArchive as Map<String, dynamic>))
        .toList();

    return ESRArchivesForYouResults(
      status: json["status"],
      resultsAreSuggestions: json['results_are_suggestions'],
      suggestedArchives: serializedArchives
    );
  }
}