import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRLikePlaylistCheckLikedPlaylistResults {
  String status = "";
  bool userLikedPlaylist = false;
  ESRLikePlaylist? likePlaylistDetails;

  ESRLikePlaylistCheckLikedPlaylistResults({
    required this.status,
    required this.userLikedPlaylist,
    required this.likePlaylistDetails
  });

  factory ESRLikePlaylistCheckLikedPlaylistResults.fromJson(Map<String, dynamic> json){
    return ESRLikePlaylistCheckLikedPlaylistResults(
        status: json['status'],
        userLikedPlaylist: json['user_liked_playlist'],
        likePlaylistDetails: (json['like_playlist_details'] == null) ? null : ESRLikePlaylist.fromJson(json['like_playlist_details'])
    );
  }
}

class ESRLikePlaylistAddResults {
  String status = "";
  String message = "";
  ESRLikePlaylist? likePlaylist;

  ESRLikePlaylistAddResults({
    required this.status,
    required this.message,
    required this.likePlaylist
  });

  factory ESRLikePlaylistAddResults.fromJson(Map<String, dynamic> json){
    return ESRLikePlaylistAddResults(
        status: json['status'],
        message: json['message'],
        likePlaylist: ESRLikePlaylist.fromJson(json['like_playlist'])
    );
  }
}

class ESRLikePlaylistDeleteResults {
  String status = "";
  String message = "";

  ESRLikePlaylistDeleteResults({
    required this.status,
    required this.message
  });

  factory ESRLikePlaylistDeleteResults.fromJson(Map<String, dynamic> json){
    return ESRLikePlaylistDeleteResults(
        status: json['status'],
        message: json['message']
    );
  }
}