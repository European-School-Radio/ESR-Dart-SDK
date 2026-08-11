import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRLikeArchiveCheckLikedArchiveResults {
  String status = "";
  bool userLikedArchive = false;
  ESRLikeArchive? likeArchiveDetails;

  ESRLikeArchiveCheckLikedArchiveResults({
    required this.status,
    required this.userLikedArchive,
    required this.likeArchiveDetails
  });

  factory ESRLikeArchiveCheckLikedArchiveResults.fromJson(Map<String, dynamic> json){
    return ESRLikeArchiveCheckLikedArchiveResults(
      status: json['status'],
      userLikedArchive: json['user_liked_archive'],
      likeArchiveDetails: (json['like_archive_details'] == null) ? null : ESRLikeArchive.fromJson(json['like_archive_details'])
    );
  }
}

class ESRLikeArchiveAddResults {
  String status = "";
  String message = "";
  ESRLikeArchive? likeArchive;

  ESRLikeArchiveAddResults({
    required this.status,
    required this.message,
    required this.likeArchive
  });
  
  factory ESRLikeArchiveAddResults.fromJson(Map<String, dynamic> json){
    return ESRLikeArchiveAddResults(
      status: json['status'],
      message: json['message'],
      likeArchive: ESRLikeArchive.fromJson(json['like_archive'])
    );
  }
}

class ESRLikeArchiveDeleteResults {
  String status = "";
  String message = "";

  ESRLikeArchiveDeleteResults({
    required this.status,
    required this.message
  });

  factory ESRLikeArchiveDeleteResults.fromJson(Map<String, dynamic> json){
    return ESRLikeArchiveDeleteResults(
      status: json['status'],
      message: json['message']
    );
  }
}