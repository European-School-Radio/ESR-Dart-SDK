import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRCommentsPaginatedResults {
  int count = 0;
  String? nextPage;
  String? previousPage;
  List<ESRComment> results = [];

  ESRCommentsPaginatedResults({
    required this.count,
    this.nextPage,
    this.previousPage,
    required this.results
  });

  factory ESRCommentsPaginatedResults.fromJson(Map<String, dynamic> json){
     List<ESRComment> serializedComments = (json['results'] as List<dynamic>)
        .map((singleComment) => ESRComment.fromJson(singleComment as Map<String, dynamic>))
        .toList();

    return ESRCommentsPaginatedResults(
        count: json['count'],
        nextPage: json['next'],
        previousPage: json['previous'],
        results: serializedComments
    );
  }
}

class ESRCommentsWebsocketListResults {
  int count = 0;
  List<ESRComment> results = [];

  ESRCommentsWebsocketListResults({
    required this.count,
    required this.results
  });

  factory ESRCommentsWebsocketListResults.fromJson(Map<String, dynamic> json, int? limit){
    List<ESRComment> serializedComments = [];

    if ((!json.containsKey("data") || json['data'] == null) && json.containsKey("count")){
      return ESRCommentsWebsocketListResults(
          count: json['count'] ?? 0,
          results: []
      );
    }

    List<dynamic> commentsList = json['data'] as List<dynamic>;

    serializedComments = commentsList
        .map((singleArchive) => ESRComment.fromJson(singleArchive as Map<String, dynamic>))
        .toList();

    return ESRCommentsWebsocketListResults(
        count: json['count'] ?? 0,
        results: serializedComments
    );
  }
}