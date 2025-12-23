import 'package:esr_dart_sdk/esr_dart_sdk.dart';

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