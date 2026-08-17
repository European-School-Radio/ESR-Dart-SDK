import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRRatingTypeArchiveByUserArchiveResults {
  String status = "";
  List<bool> ratingTypeHasVote = [];
  List<double> ratingTypeVoteValue = [];
  List<int> ratingTypeVoteID = [];

  ESRRatingTypeArchiveByUserArchiveResults({
    required this.status,
    required this.ratingTypeHasVote,
    required this.ratingTypeVoteValue,
    required this.ratingTypeVoteID
  });

  factory ESRRatingTypeArchiveByUserArchiveResults.fromJson(Map<String, dynamic> json) {
    List<bool> serializedRatingTypeHasVotes = (json['rating_type_has_vote'] == null) ? [] : (json['rating_type_has_vote'] as List<dynamic>)
        .map((singleHasVote) => bool.parse(singleHasVote))
        .toList();

    List<double> serializedRatingTypeVoteValue = (json['rating_type_vote_value'] == null) ? [] : (json['rating_type_vote_value'] as List<dynamic>)
        .map((singleVoteValue) => double.parse(singleVoteValue))
        .toList();

    List<int> serializedRatingTypeVoteID = (json['rating_type_vote_id'] == null) ? [] : (json['rating_type_vote_id'] as List<dynamic>)
        .map((singleVoteID) => int.parse(singleVoteID))
        .toList();

    return ESRRatingTypeArchiveByUserArchiveResults(
      status: json['status'],
      ratingTypeHasVote: serializedRatingTypeHasVotes,
      ratingTypeVoteValue: serializedRatingTypeVoteValue,
      ratingTypeVoteID: serializedRatingTypeVoteID,
    );
  }
}

class ESRRatingTypeArchiveAddResults {
  String status = "";
  String message = "";
  ESRRatingTypeArchive? ratingTypesArchive;

  ESRRatingTypeArchiveAddResults({
    required this.status,
    required this.message,
    required this.ratingTypesArchive
  });
  
  factory ESRRatingTypeArchiveAddResults.fromJson(Map<String, dynamic> json){
    return ESRRatingTypeArchiveAddResults(
      status: json['status'],
      message: json['message'],
      ratingTypesArchive: ESRRatingTypeArchive.fromJson(json['rating_types_archive'])
    );
  }
}

class ESRRatingTypeArchiveEditResults {
  String status = "";
  String message = "";

  ESRRatingTypeArchiveEditResults({
    required this.status,
    required this.message
  });

  factory ESRRatingTypeArchiveEditResults.fromJson(Map<String, dynamic> json){
    return ESRRatingTypeArchiveEditResults(
      status: json['status'],
      message: json['message']
    );
  }
}

class ESRRatingTypeArchiveDeleteResults {
  String status = "";
  String message = "";

  ESRRatingTypeArchiveDeleteResults({
    required this.status,
    required this.message
  });

  factory ESRRatingTypeArchiveDeleteResults.fromJson(Map<String, dynamic> json){
    return ESRRatingTypeArchiveDeleteResults(
        status: json['status'],
        message: json['message']
    );
  }
}