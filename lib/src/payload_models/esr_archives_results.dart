import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRArchivesAddResults {
  String status;
  String message;
  ESRArchive archive;

  ESRArchivesAddResults({
    required this.status,
    required this.message,
    required this.archive
  });

  factory ESRArchivesAddResults.fromJson(Map<String, dynamic> json){
    return ESRArchivesAddResults(
        status: json["status"],
        message: json["message"],
        archive: ESRArchive.fromJson(json["archive"])
    );
  }
}

class ESRArchivesCountryPopularResults {
  String status = "";
  String countryFlag = "";
  List<ESRArchive> countryPopularArchives = [];

  ESRArchivesCountryPopularResults({
    required this.status,
    required this.countryFlag,
    required this.countryPopularArchives
  });

  factory ESRArchivesCountryPopularResults.fromJson(Map<String, dynamic> json){
    List<ESRArchive> serializedArchives = [];

    List<dynamic> archivesList = json['country_popular_archives'] as List<dynamic>;

    serializedArchives = archivesList
        .map((singleArchive) => ESRArchive.fromJson(singleArchive as Map<String, dynamic>))
        .toList();

    return ESRArchivesCountryPopularResults(
        status: json["status"],
        countryFlag: json['country_flag'],
        countryPopularArchives: serializedArchives
    );
  }
}

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

class ESRArchivesPopularPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRArchive> results = [];

  ESRArchivesPopularPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRArchivesPopularPaginatedResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRArchive> serializedArchives = [];

    List<dynamic> archivesList = (json['popular_archives'] ?? json['results']) as List<dynamic>;

    serializedArchives = archivesList
        .map((singleArchive) => ESRArchive.fromJson(singleArchive as Map<String, dynamic>))
        .toList();

    return ESRArchivesPopularPaginatedResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedArchives.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedArchives
    );
  }
}

class ESRArchivesSimilarResults {
  String status = "";
  List<ESRArchive> similarArchives = [];

  ESRArchivesSimilarResults({
    required this.status,
    required this.similarArchives
  });

  factory ESRArchivesSimilarResults.fromJson(Map<String, dynamic> json){
    List<ESRArchive> serializedArchives = [];

    List<dynamic> archivesList = json['similar_archives'] as List<dynamic>;

    serializedArchives = archivesList
        .map((singleArchive) => ESRArchive.fromJson(singleArchive as Map<String, dynamic>))
        .toList();

    return ESRArchivesSimilarResults(
        status: json["status"],
        similarArchives: serializedArchives
    );
  }
}

class ESRArchivesMultipleResults {
  String status = "";
  List<ESRArchive> archivesList = [];

  ESRArchivesMultipleResults({
    required this.status,
    required this.archivesList
  });

  factory ESRArchivesMultipleResults.fromJson(Map<String, dynamic> json){
    List<ESRArchive> serializedArchives = [];

    List<dynamic> archivesList = json['archives_list'] as List<dynamic>;

    serializedArchives = archivesList
        .map((singleArchive) => ESRArchive.fromJson(singleArchive as Map<String, dynamic>))
        .toList();

    return ESRArchivesMultipleResults(
      status: json["status"],
      archivesList: serializedArchives
    );
  }
}

class ESRArchivesListResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRArchive> results = [];

  ESRArchivesListResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRArchivesListResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRArchive> serializedArchives = [];

    List<dynamic> archivesList = (json['archives'] ?? json['results']) as List<dynamic>;

    serializedArchives = archivesList
        .map((singleArchive) => ESRArchive.fromJson(singleArchive as Map<String, dynamic>))
        .toList();

    return ESRArchivesListResults(
        count: (limit == null || limit != -1) ? json['count'] : serializedArchives.length,
        nextPage: (limit == null || limit != -1) ? json['next'] : null,
        previousPage: (limit == null || limit != -1) ? json['previous'] : null,
        results: serializedArchives
    );
  }
}