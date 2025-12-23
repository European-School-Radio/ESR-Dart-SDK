import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRPopularArchivesPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRArchive> results = [];

  ESRPopularArchivesPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRPopularArchivesPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRArchive> serializedArchives = [];

    List<dynamic> archivesList;
    if (limit == null || limit == -1){
      archivesList = json['results'] as List<dynamic>;
    } else {
      archivesList = json['popular_archives'] as List<dynamic>;
    }

    serializedArchives = archivesList
        .map((singleArchive) => ESRArchive.fromJson(singleArchive as Map<String, dynamic>))
        .toList();

    return ESRPopularArchivesPaginatedResults(
      count: (limit == null || limit != -1) ? json['count'] : serializedArchives.length,
      nextPage: (limit == null || limit != -1) ? json['next'] : null,
      previousPage: (limit == null || limit != -1) ? json['previous'] : null,
      results: serializedArchives
    );
  }
}