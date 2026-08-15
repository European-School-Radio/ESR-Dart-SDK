import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRFollowPlaylistsPaginatedResults {
  int count = 0;
  List<ESRFollowPlaylist>? followPlaylists;

  ESRFollowPlaylistsPaginatedResults({
    required this.count,
    required this.followPlaylists
  });

  factory ESRFollowPlaylistsPaginatedResults.fromJson(Map<String, dynamic> json){
    List<dynamic> followPlaylistsList = json['data'] as List<dynamic>;
    List<ESRFollowPlaylist> serializedPlaylistFollows = [];

    serializedPlaylistFollows = followPlaylistsList
        .map((singleFollowPlaylist) => ESRFollowPlaylist.fromJson(singleFollowPlaylist as Map<String, dynamic>))
        .toList();

    return ESRFollowPlaylistsPaginatedResults(
        count: json['count'] ?? 0,
        followPlaylists: serializedPlaylistFollows
    );
  }
}

class ESRFollowPlaylistCheckFollowedPlaylistResults {
  String status = "";
  bool userFollowedPlaylist = false;
  ESRFollowPlaylist? followPlaylistDetails;

  ESRFollowPlaylistCheckFollowedPlaylistResults({
    required this.status,
    required this.userFollowedPlaylist,
    required this.followPlaylistDetails
  });

  factory ESRFollowPlaylistCheckFollowedPlaylistResults.fromJson(Map<String, dynamic> json){
    return ESRFollowPlaylistCheckFollowedPlaylistResults(
        status: json['status'],
        userFollowedPlaylist: json['user_followed_playlist'],
        followPlaylistDetails: (json['follow_playlist_details'] == null) ? null : ESRFollowPlaylist.fromJson(json['follow_playlist_details'])
    );
  }
}

class ESRFollowPlaylistAddResults {
  String status = "";
  String message = "";
  ESRFollowPlaylist? followPlaylist;

  ESRFollowPlaylistAddResults({
    required this.status,
    required this.message,
    required this.followPlaylist
  });

  factory ESRFollowPlaylistAddResults.fromJson(Map<String, dynamic> json){
    return ESRFollowPlaylistAddResults(
        status: json['status'],
        message: json['message'],
        followPlaylist: ESRFollowPlaylist.fromJson(json['follow_playlist'])
    );
  }
}

class ESRFollowPlaylistDeleteResults {
  String status = "";
  String message = "";

  ESRFollowPlaylistDeleteResults({
    required this.status,
    required this.message
  });

  factory ESRFollowPlaylistDeleteResults.fromJson(Map<String, dynamic> json){
    return ESRFollowPlaylistDeleteResults(
        status: json['status'],
        message: json['message']
    );
  }
}