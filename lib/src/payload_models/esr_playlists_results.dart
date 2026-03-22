import 'package:esr_dart_sdk/esr_dart_sdk.dart';

class ESRPlaylistsByUserResults {
  int count = 0;
  List<ESRPlaylist> results = [];

  ESRPlaylistsByUserResults({
    required this.count,
    required this.results
  });

  factory ESRPlaylistsByUserResults.fromJson(Map<String, dynamic> json){
    List<ESRPlaylist> serializedPlaylists = [];

    if ((!json.containsKey("data") || json['data'] == null) && json.containsKey("count")){
      return ESRPlaylistsByUserResults(
          count: json['count'] ?? 0,
          results: []
      );
    }

    List<dynamic> playlistsList = json['data'] as List<dynamic>;

    serializedPlaylists = playlistsList
        .map((singlePlaylist) => ESRPlaylist.fromJson(singlePlaylist as Map<String, dynamic>))
        .toList();

    return ESRPlaylistsByUserResults(
      count: json['count'] ?? 0,
      results: serializedPlaylists
    );
  }
}

class ESRPlaylistsIncreaseSharesCounterResults {
  String status = "";
  String message = "";

  ESRPlaylistsIncreaseSharesCounterResults({
    required this.status,
    required this.message
  });

  factory ESRPlaylistsIncreaseSharesCounterResults.fromJson(Map<String, dynamic> json){
    return ESRPlaylistsIncreaseSharesCounterResults(
      status: json['status'],
      message: json['message']
    );
  }
}

class ESRPlaylistsSharesCounterByPlaylistResults {
  int count = 0;

  ESRPlaylistsSharesCounterByPlaylistResults({
    required this.count
  });

  factory ESRPlaylistsSharesCounterByPlaylistResults.fromJson(Map<String, dynamic> json){
    return ESRPlaylistsSharesCounterByPlaylistResults(
      count: json['count']
    );
  }
}

class ESRPlaylistsFollowersByPlaylistResults {
  int count = 0;
  List<ESRFollowPlaylist> data = [];

  ESRPlaylistsFollowersByPlaylistResults({
    required this.count,
    required this.data
  });

  factory ESRPlaylistsFollowersByPlaylistResults.fromJson(Map<String, dynamic> json){
    List<ESRFollowPlaylist> serializedFollowPlaylists = [];

    List<dynamic> playlistsList = json['data'] as List<dynamic>;

    serializedFollowPlaylists = playlistsList
        .map((singlePlaylistFollower) => ESRFollowPlaylist.fromJson(singlePlaylistFollower as Map<String, dynamic>))
        .toList();

    return ESRPlaylistsFollowersByPlaylistResults(
        count: json['count'],
        data: serializedFollowPlaylists
    );
  }
}

class ESRPlaylistsLikesCounterByPlaylistResults {
  int count = 0;

  ESRPlaylistsLikesCounterByPlaylistResults({
    required this.count
  });

  factory ESRPlaylistsLikesCounterByPlaylistResults.fromJson(Map<String, dynamic> json){
    return ESRPlaylistsLikesCounterByPlaylistResults(
      count: json['count']
    );
  }
}

class ESRPlaylistsArchivesByPlaylistResults {
  int count = 0;
  List<ESRPlaylistArchive> playlistArchives = [];

  ESRPlaylistsArchivesByPlaylistResults({
    required this.count,
    required this.playlistArchives
  });

  factory ESRPlaylistsArchivesByPlaylistResults.fromJson(Map<String, dynamic> json){
    List<ESRPlaylistArchive> serializedPlaylistArchives = [];

    List<dynamic> playlistArchivesList = json['data'] as List<dynamic>;

    serializedPlaylistArchives = playlistArchivesList
        .map((singlePlaylistArchive) => ESRPlaylistArchive.fromJson(singlePlaylistArchive as Map<String, dynamic>))
        .toList();

    return ESRPlaylistsArchivesByPlaylistResults(
      count: json['count'],
      playlistArchives: serializedPlaylistArchives
    );
  }
}