import 'package:esr_dart_sdk/esr_dart_sdk.dart';

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